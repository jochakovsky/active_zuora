require 'savon'
require 'active_model'
require 'active_support/all'

require 'active_zuora/connection'
require 'active_zuora/generator'
require 'active_zuora/fields'
require 'active_zuora/belongs_to_association'
require 'active_zuora/base'
require 'active_zuora/scope'
require 'active_zuora/querying'
require 'active_zuora/persistence'
require 'active_zuora/has_many_association'
require 'active_zuora/z_object'
require 'active_zuora/subscribe'

module ActiveZuora

  # Setup configuration.  None of this sends a request.
  def self.configure(configuration)
    # Set some sensible defaults with the savon SOAP client.
    Savon.configure do |config|
      config.log = HTTPI.log = configuration[:log] || false
      config.log_level = configuration[:log_level] || :info
      config.raise_errors = true
    end
    # Create a default connection on Base
    Base.connection = Connection.new(configuration)
  end

  def self.generate_classes(options={})
    generator = Generator.new(Base.connection.soap_client.wsdl.parser, options)
    generator.generate_classes
  end

end
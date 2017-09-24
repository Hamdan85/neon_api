module NeonApi
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def self.client
    self.configuration.client
  end

  class Configuration
    attr_accessor :environment, :token, :client

    def initialize
      @environment = :development
      @token       = 'no-token'

      @client      ||= Client.new(@environment, @token)
    end
  end
end
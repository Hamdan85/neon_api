module NeonApi
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
    self.configuration.client_setup
  end

  def self.client
    self.configuration.client
  end

  # Configuration
  class Configuration
    attr_accessor :environment, :token, :client, :username, :password, :encrypt_pem, :decrypt_pem

    def client_setup
      @client ||= Client.new(environment, token, username, password, encrypt_pem, decrypt_pem)
      @client.authenticate
    end
  end
end
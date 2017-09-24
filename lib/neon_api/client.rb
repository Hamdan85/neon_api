module NeonApi
  require "rest-client"

  class Client
    attr_accessor :base_url, :method, :url, :environment, :payload, :token
    def initialize(environment = :development, token)
      @base_url = if production?
                  else
                    'https://servicosdev.neonhomol.com.br/servicopj/'
                  end
      @token    = token
    end

    def send(method, url, payload)
      RestClient::Request.execute(method: method.to_sym, url: url,
                                  payload: payload, headers: headers)
    end

    def production?
      @environment == :production
    end

    def headers
      {
          "cache-control": "no-cache",
          "content-type": "application/x-www-form-urlencoded",
          "token": token
      }
    end
  end
end
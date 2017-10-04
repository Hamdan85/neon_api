module NeonApi
  module GetAccountTypes
    URL = 'V1/Transfer/GetAccountTypes'
    def self.create
      NeonApi.client.send_request(payload, URL)
    end

    def self.payload
      {
          "ClientID": NeonApi.client.client_id
      }.to_json
    end
  end
end


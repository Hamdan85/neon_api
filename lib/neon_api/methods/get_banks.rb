module NeonApi
  module GetBanks
    URL = 'V1/Transfer/GetBanks'
    def self.get
      NeonApi.client.send_request(payload, URL)
    end

    def self.payload
      {
          "ClientID": NeonApi.client.client_id
      }.to_json
    end
  end
end


module NeonApi
  module GetAccounts
    URL = 'V1/SubAccount/GetAccounts'
    def self.get
      NeonApi.client.send_request(payload, URL)
    end

    def self.payload
      {
          "ClientID": NeonApi.client.client_id,
      }.to_json
    end
  end
end
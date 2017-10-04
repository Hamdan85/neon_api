module NeonApi
  module Balance
    URL = 'V1/Client/GetBalanceAccount'

    def self.get_balance
      NeonApi.client.send_request(payload, URL)
    end

    def self.payload
      {
          "ClientID": NeonApi.client.client_id
      }.to_json
    end
  end
end
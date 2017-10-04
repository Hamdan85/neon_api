module NeonApi
  module CreateSubAccount
    URL = 'V1/SubAccount/CreateSubAccount'
    def self.create(name, percentage, main_percentage)
      NeonApi.client.send_request(payload(name, percentage, main_percentage), URL)
    end

    def self.payload(name, percentage, main_percentage)
      {
          "ClientID": NeonApi.client.client_id,
          "SubAccountName": name,
          "PercentageRedemption": percentage,
          "PercentageRedemptionMain": main_percentage
      }.to_json
    end
  end
end
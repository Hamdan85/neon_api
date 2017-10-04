module NeonApi
  module ConfirmPayment
    URL = 'V1/PaymentSlip/ConfirmPayment'
    def self.create(list_uniq_id)
      NeonApi.client.send_request(payload(list_uniq_id), URL)
    end

    def self.payload(list_uniq_id)
      {
          "ClientID": NeonApi.client.client_id,
          "ListUniqueId": list_uniq_id
      }.to_json
    end
  end
end


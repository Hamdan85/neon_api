module NeonApi
  module CancelPayment
    URL = 'V1/PaymentSlip/CancelPayment'
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


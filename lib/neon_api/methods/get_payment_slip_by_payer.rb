module NeonApi
  module GetPaymentSlipByPayer
    URL = 'V1/PaymentSlip/GetPaymentSlipByPayer'
    def self.create(payer_id)
      NeonApi.client.send_request(payload(payer_id), URL)
    end

    def self.payload(payer_id)
      {
          "PayerId": payer_id,
          "ClientID": NeonApi.client.client_id,
      }.to_json
    end
  end
end


module NeonApi
  module GetPaymentSlipBySubAccount
    URL = 'V1/PaymentSlip/GetPaymentSlipBySubAccount'
    def self.create(payer_id, bank_account_id)
      NeonApi.client.send_request(payload(payer_id, bank_account_id), URL)
    end

    def self.payload(payer_id, bank_account_id)
      {
          "PayerId": payer_id,
          "BankAccountId": bank_account_id
      }.to_json
    end
  end
end


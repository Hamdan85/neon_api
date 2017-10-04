module NeonApi
  module GetPayers
    URL = 'V1/Payer/GetPayersBySubAccount'
    def self.create(bank_acc_id, name, cpf, email, address, number, complement, zipcode, city, state, country)
      NeonApi.client.send_request(payload(bank_acc_id, name, cpf, email, address, number, complement, zipcode, city, state, country), URL)
    end

    def self.payload(bank_acc_id, name, cpf, email, address, number, complement, zipcode, city, state, country)
      {
          "BankAccountId": bank_acc_id,
          "ClientID": NeonApi.client.client_id,
      }.to_json
    end
  end
end


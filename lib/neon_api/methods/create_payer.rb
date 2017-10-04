module NeonApi
  module CreatePayer
    URL = 'V1/Payer/CreatePayersBySubAccount'
    def self.create(bank_acc_id, name, cpf, email, address, number, complement, zipcode, city, state, country)
      NeonApi.client.send_request(payload(bank_acc_id, name, cpf, email, address, number, complement, zipcode, city, state, country), URL)
    end

    def self.payload(bank_acc_id, name, cpf, email, address, number, complement, zipcode, city, state, country)
      {
          "BankAccountId": bank_acc_id,
          "Name": name,
          "CPF": cpf,
          "Email": email,
          "ClientID": NeonApi.client.client_id,
          "Address": address,
          "Number": number,
          "Complement": complement,
          "PostalCode": zipcode,
          "City": city,
          "State": state,
          "Country": country
      }.to_json
    end
  end
end


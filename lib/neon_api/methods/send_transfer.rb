module NeonApi
  module SendTransfer
    URL = 'V1/Transfer/SendTransfer'
    def self.create(bank_account_id, finality_id, description, credit_to_bank, account_type, branch, bank_account_number, name, document, value, scheduled_to)
      NeonApi.client.send_request(payload(bank_account_id, finality_id, description, credit_to_bank, account_type, branch, bank_account_number, name, document, value, scheduled_to), URL)
    end

    def self.payload(bank_account_id, finality_id, description, credit_to_bank, account_type = "CC", branch = "1", bank_account_number, name, document, value, scheduled_to)
      {
          "BankAccountId": bank_account_id,
          "FinalityId": finality_id,
          "Description": description,
          "CreditTo": {
              "CodBank": credit_to_bank,
              "AccountyType": account_type,
              "Branch": branch,
              "BankAccountNumber": bank_account_number,
              "Name": name,
              "Document": document,
              "Value": value,
              "SchedulingDate": scheduled_to
          },
          "ClientID": NeonApi.client.client_id
      }.to_json
    end
  end
end


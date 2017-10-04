module NeonApi
  module SendPayment
    URL = 'V1/PaymentSlip/SendPayment'
    def self.create(description, bar_code, due_date, value, discount, tx)
      NeonApi.client.send_request(payload(description, bar_code, due_date, value, discount, tx), URL)
    end

    def self.payload(description, bar_code, due_date, value, discount, tx)
      {
          "ClientId": NeonApi.client.client_id,
          "Payments": [
              {
                  "description": description,
                  "BarCodeNumber": bar_code,
                  "DueDate": due_date,
                  "Assignor": "Cedente",
                  "Value": value,
                  "Discount": discount,
                  "TaxValue": tx
              }
          ]
      }.to_json
    end
  end
end


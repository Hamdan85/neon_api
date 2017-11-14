module NeonApi
  module GetStatement
    URL = 'V1/Statement/GetStatement'

    def self.get(month, year)
      NeonApi.client.send_request(payload(month, year), URL)
    end

    def self.payload(month, year)
      {
        'ClientID': NeonApi.client.client_id,
        'Year': year,
        'Month': month
      }.to_json
    end
  end
end

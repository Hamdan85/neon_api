module NeonApi
  module ConfirmTransfer
    URL = 'V1/Transfer/ConfirmTransfer'
    def self.create(uniq_id)
      NeonApi.client.send_request(payload(uniq_id), URL)
    end

    def self.payload(uniq_id)
      {
          "ClientID": NeonApi.client.client_id,
          "UniqueId": uniq_id
      }.to_json
    end
  end
end


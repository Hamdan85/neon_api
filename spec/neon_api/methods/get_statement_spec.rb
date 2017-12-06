require 'spec_helper'

RSpec.describe NeonApi::GetStatement do
  before do
    NeonApi.configure do |config|
      config.token    = 'neon-token'
      config.username = 'neon-username'
      config.password = 'neon-pass'
      config.encrypt_pem = '/etc/public.pem'
      config.decrypt_pem = '/etc/private.pem'
      config.environment = :test
    end

    allow_any_instance_of(NeonApi::Client).to receive(:authenticate).and_return(true)
    allow_any_instance_of(NeonApi::Client).to receive(:send_request)
  end

  describe ".get" do
    it 'sends the payload to GetStatement' do
      expect_any_instance_of(NeonApi::Client).to receive(:send_request).with(
        "{\"ClientID\":null,\"Year\":2017,\"Month\":11}",
        "V1/Statement/GetStatement"
      )

      NeonApi::GetStatement.get(11, 2017)
    end
  end

  describe ".payload" do
    it 'returns the correct payload in json format' do
      expect(NeonApi::GetStatement.payload(11, 2017)).to eq("{\"ClientID\":null,\"Year\":2017,\"Month\":11}")
    end
  end
end

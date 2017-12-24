require 'spec_helper'

RSpec.describe NeonApi::GetStatement do
  let(:args) { [11, 2017] }
  let(:expected_payload) { "{\"ClientID\":null,\"Year\":2017,\"Month\":11}" }
  let(:expected_url) { "V1/Statement/GetStatement"}

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
        expected_payload, expected_url
      )

      subject.get(*args)
    end
  end

  describe ".payload" do
    it 'returns the correct payload in json format' do
      expect(subject.payload(*args)).to eq(expected_payload)
    end
  end
end

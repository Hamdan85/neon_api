require 'spec_helper'

RSpec.describe NeonApi::SendTransfer do
  let(:args) { [666, 1, "Transfer", 735, 2, 1, 123456, "Foo", "987654321", 120.0, "2017-12-24 00:00:00"] }
  let(:expected_payload) { "{\"BankAccountId\":666,\"FinalityId\":1,\"Description\":\"Transfer\",\"CreditTo\":{\"CodBank\":735,\"AccountyType\":2,\"Branch\":1,\"BankAccountNumber\":123456,\"Name\":\"Foo\",\"Document\":\"987654321\",\"Value\":120.0,\"SchedulingDate\":\"2017-12-24 00:00:00\"},\"ClientID\":null}" }
  let(:expected_url) { "V1/Transfer/SendTransfer" }

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

  describe ".create" do
    it 'sends the payload to SendTransfer' do
      expect_any_instance_of(NeonApi::Client).to receive(:send_request).with(
        expected_payload, expected_url
      )

      subject.create(*args)
    end
  end

  describe ".payload" do
    it 'returns the correct payload in json format' do
      expect(subject.payload(*args)).to eq(expected_payload)
    end
  end
end

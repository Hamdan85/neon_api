require "spec_helper"

RSpec.describe NeonApi::Client do

  describe '#base_url' do

    let(:client) { described_class.new(environment, 'token-example', 'login', 'password', '/path/to/encrypt.pem', '/path/to/decrypt.pem', nil) }

    context 'when environment is production' do
      let(:environment) { :production }

      it 'sets the correct base_url' do
        expect(client.base_url).to eq('https://apiparceiros.banconeon.com.br/')
      end
    end

    context 'when environment is not production' do
      let(:environment) { :development }

      it 'sets the correct base_url' do
        expect(client.base_url).to eq('https://servicosdev.neonhomol.com.br/servicopj/')
      end
    end
  end
end

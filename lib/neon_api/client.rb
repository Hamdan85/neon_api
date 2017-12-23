module NeonApi
  require "rest-client"
  require "openssl"
  require "aes"
  require "base64"
  require "json"

  class Client
    attr_accessor :url, :environment, :payload, :token, :last_authenticated_at, :response,
                  :auth_token, :aes_key, :aes_iv, :expire_time, :client_id, :bank_account, :response, :base_url

    def initialize(environment, token, login, password, encrypt_pem, decrypt_pem, proxy)
      @environment  = environment
      @token        = token
      @username     = login
      @password     = password
      @encrypt_pem  = encrypt_pem
      @decrypt_pem  = decrypt_pem
      @proxy        = proxy
      @expire_time  = Time.now

      RestClient.proxy = @proxy if @proxy
    end

    def authenticate
      @last_authenticated_at = Time.now

      request = begin
        RestClient::Request.execute(method: :post, url: "#{base_url}/V1/Client/Authentication",
                                    payload: { "Data": encrypted_payload(authentication: true) }, headers: auth_headers)
      rescue RestClient::ExceptionWithResponse => err
        err.response
      end

      if request.code == 200
        update_auth JSON.parse(decrypt_payload(payload: JSON.parse(request.body)["Data"], authentication: true))
      else
        raise request
      end
    end

    def send_request(object, url)

      authenticate if Time.now > expire_time

      request = begin
        RestClient::Request.execute(method: :post, url: base_url + url,
                                    payload: { "Data": encrypted_payload(payload: object) }, headers: headers)
      rescue RestClient::ExceptionWithResponse => err
        err.response
      end

      if request.code != 500
        @response = JSON.parse(decrypt_payload(payload: JSON.parse(request.body)['Data']))
      else
        @response = request
      end

      return @response
    end

    def production?
      @environment == :production
    end

    def auth_headers
      {
          "Cache-Control": "no-cache",
          "Content-Type": "application/x-www-form-urlencoded",
          "Token": token
      }
    end

    def headers
      {
          "Cache-Control": "no-cache",
          "Content-Type": "application/x-www-form-urlencoded",
          "Token": auth_token
      }
    end

    def update_auth(auth_answer)
      @auth_token = auth_answer['DataReturn']['Token']
      @aes_key = auth_answer['DataReturn']['AESKey']
      @aes_iv = auth_answer['DataReturn']['AESIV']
      @expire_time = Time.at(auth_answer['DataReturn']['DataExpiracao'].gsub(/[^\d]/, '').to_i)
      @client_id = auth_answer['DataReturn']['ClientId']
      @bank_account = auth_answer['DataReturn']['BankAccountId']
    end

    def encrypted_payload(payload: self.payload, authentication: false)
      if authentication
        Base64.encode64 OpenSSL::PKey::RSA.new(File.read(@encrypt_pem)).public_encrypt(payload)
      else
        Base64.encode64(aes_cipher(:encrypt, payload))
      end
    end

    def decrypt_payload(payload:, authentication: false)
      if authentication
        OpenSSL::PKey::RSA.new(File.read(@decrypt_pem)).private_decrypt(Base64.decode64 payload)
      else
        aes_cipher(:decrypt, Base64.decode64(payload))
      end
    end

    def aes_cipher(method, payload)
      cipher = OpenSSL::Cipher::AES.new(256, :CBC)
      cipher.send(method)
      cipher.key      = aes_key.map { |u| u.chr }.join
      cipher.iv       = aes_iv.map { |u| u.chr }.join
      (cipher.update(payload) + cipher.final).force_encoding('UTF-8')
    end

    def payload
      {
          "Username": @username,
          "Password": @password,
          "RequestDate": Time.now.strftime('%Y-%m-%dT%H:%M:%S')
      }.to_json
    end

    def base_url
      @base_url ||= production? ? 'https://apiparceiros.banconeon.com.br/' : 'https://servicosdev.neonhomol.com.br/servicopj/'
    end
  end
end

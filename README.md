[![Gem Version](https://badge.fury.io/rb/neon_api.svg)](https://badge.fury.io/rb/neon_api)


# NeonApi

Gem used to integrate any rails system to Bank NeonApi

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'neon_api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install neon_api

## Usage

Initialize the system on its own initializer file:

config/initializer/neon_api.rb
```ruby
NeonApi.configure do |config|
  config.token = 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX'
  config.username = 'user@name.com'
  config.password = 'password'
  config.proxy        = 'http://dasd:asd@asd.asd.com:80'      # neon needs a fixed outbound ip
  config.encrypt_pem  = 'public_encrypt.pem'                  # path to your encryption pem 
  config.decrypt_pem  = 'public_decrypt.pem'                  # path to your decryption pem
  config.environment  = :development                          # environment :development or :production
end
```

PS: YOU WILL NEED TO CHANGE YOUR KEYS FROM XML TO PEM!!! THIS IS IMPORTANT!
you can use this(https://superdry.apphb.com/tools/online-rsa-key-converter) for this purpose.

Use the bank methods in order to create or manage your transactions:

Get Balance:
```ruby
NeonApi::Balance.get_balance
```

Create Payer:
```ruby
NeonApi::CreatePayer.create(bank_acc_id, name, cpf, email, address, number, complement, zipcode, city, state, country)
```

CancelPayment:
```ruby
NeonApi::CancelPayment.create(list_uniq_id)
```

ConfirmPayment
```ruby
NeonApi::ConfirmPayment.create(list_uniq_id)
```

Generate Payment Slip
```ruby
GeneratePaymentSlipToPayer.create(bank_acc_id, name, cpf, email, address, number, complement, zipcode, city, state, country)
```
More methods (and their arguments) can be found on methods folder

## Development

I made this for myself, in a hurry. It works but it's not tested or well documented. Sorry for that.

## Contributing
BUUUUUT... You can help!!!!
Help me to test and document it. It's good for everybody. (please rspec)

Bug reports and pull requests are welcome on GitHub at https://github.com/Hamdan85/neon_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NeonApi project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/neon_api/blob/master/CODE_OF_CONDUCT.md).

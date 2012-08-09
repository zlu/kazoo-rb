require 'bundler/setup'
require 'webmock/rspec'
require 'kazoo'

RSpec.configure do |config|
  config.include RSpec::Matchers
end

def kazoo_config
  {   'api_key' => 'your_kazoo_developer_api_key' + '*' * 36,
      'account_id' => 'your_account_id' + '*' * 17,
      'host' => 'api.2600hz.com',
      'port' => '8000',
      'version' => 'v1',
  }
end

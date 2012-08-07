require 'bundler/setup'
require 'webmock/rspec'
require 'kazoo'

RSpec.configure do |config|
  config.include RSpec::Matchers
end
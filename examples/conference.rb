#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'kazoo'

def init_config
  YAML.load(File.open(File.join(File.expand_path("../../lib", __FILE__), 'kazoo.yml')))
end

phone_number = []
ARGV.each do |number|
  phone_number << number
end

auth = Kazoo::Auth.new(init_config)
conf = Kazoo::Conference.new(auth)
conf.create_callflow(phone_number)
conf.create_room('test conf room', ['1234'])


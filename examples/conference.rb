#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'kazoo'

phone_number = []
ARGV.each do |number|
  phone_number << number
end

auth = Kazoo::Auth.new
conf = Kazoo::Conference.new(auth)
conf.create_callflow(phone_number)
conf.create_room('test conf room', ['1234'])
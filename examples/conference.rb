#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'kazoo'

auth = Kazoo::Auth.new
conf = Kazoo::Conference.new(auth)
conf.create_callflow(['+14151113456'])
conf.create_room('test conf room', ['1234'])
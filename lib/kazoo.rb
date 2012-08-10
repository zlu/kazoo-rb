require 'json'
require 'nestful'

$:.unshift(File.dirname(__FILE__))
require 'kazoo/auth'
require 'kazoo/conference'
require 'kazoo/connection_error'

module Kazoo
  extend self
end
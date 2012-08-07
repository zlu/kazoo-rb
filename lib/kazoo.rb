require 'json'
require 'nestful'

$:.unshift(File.dirname(__FILE__))
require 'kazoo/auth'
require 'kazoo/conference'

module Kazoo
  extend self

  def create_conference
    'create_conference'
  end
end
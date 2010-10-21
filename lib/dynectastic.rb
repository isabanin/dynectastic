require 'httparty'
require 'json'
require "dynectastic/errors"
require "dynectastic/resource"
require "dynectastic/session"
require "dynectastic/zone"
require "dynectastic/record"
require "dynectastic/factories/zone_factory"
require "dynectastic/factories/record_factory"

module Dynectastic
  
  extend self
  
  def session(customer_name, user_name, password)
    Session.new(customer_name, user_name, password)
  end
  
end
require 'httparty'
require 'json'

module Dynectastic
  
  extend self
  
  VERSION  = '0.1.2'
  API_BASE = 'https://api2.dynect.net/REST' 
  
  def session(customer_name, user_name, password)
    Session.new(customer_name, user_name, password)
  end
  
end

require "dynectastic/errors"
require "dynectastic/error_translator"
require "dynectastic/resource"
require "dynectastic/session"
require "dynectastic/zone"
require "dynectastic/record"
require "dynectastic/factories/zone_factory"
require "dynectastic/factories/node_factory"
require "dynectastic/factories/record_factory"
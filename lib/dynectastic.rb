require 'httparty'
require 'json'

module Dynectastic
  
  VERSION = '0.2.0'
  API_URL = 'https://api2.dynect.net'
  RETRIES = 5
  
  def self.session(customer_name, user_name, password)
    Session.new(customer_name, user_name, password)
  end
  
end

require "dynectastic/errors"
require "dynectastic/error_translator"
require "dynectastic/request"
require "dynectastic/resource"
require "dynectastic/session"
require "dynectastic/zone"
require "dynectastic/record"
require "dynectastic/job"
require "dynectastic/factories/zone_factory"
require "dynectastic/factories/node_factory"
require "dynectastic/factories/record_factory"
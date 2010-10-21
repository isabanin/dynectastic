require 'rubygems'
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'dynectastic'

DYNECT_CUST_NAME = "xxx"
DYNECT_USER_NAME = "xxx"
DYNECT_USER_PASS = "xxx"

class Test::Unit::TestCase
end
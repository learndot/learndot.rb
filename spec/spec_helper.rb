#we need the actual library file
require_relative '../lib/learndot'

#dependencies
require 'rspec/autorun'

TEST_API_KEY = 'VzpehxD3l6QtTvBNm8Bz1Qbz6_d8BcA6Ypo7KhNHRP0'
TEST_URL = 'staging.learndot.com'

def anonymous_string(length=8)
  (0...length).map { (65+rand(26)).chr }.join
end

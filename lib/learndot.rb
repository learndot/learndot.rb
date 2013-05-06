require "learndot/version"
require "httparty"
require "persistent_httparty"

module Learndot
  autoload :Errors, 'learndot/errors'
  autoload :Records, 'learndot/records'
  autoload :Unicorn, 'learndot/unicorn'
end
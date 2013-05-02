module Learndot

  # Wrapper for the unicorn api
  class Unicorn

    include HTTParty
    format :json

    attr_accessor :learndot_url, :api_key

    def self.learndot_url
      @@learndot_url
    end

    def self.learndot_url=(url)
      @@learndot_url = url
    end

    def self.api_key
      @@api_key
    end

    def self.api_key=(key)
      @@api_key = key
    end

    #def self.base_uri
    #  "http://#{@@learndot_url}"
    #end

    def options
      {
          :headers => {
              'Authorization' => "learndotApiKey=#{@@api_key}"
          }
      }
    end

    def base_url
      "http://#{@@learndot_url}/api/"
    end

    def url(url)
      "#{base_url}/#{url}"
    end

    def organization
      attrs = self.class.get(url("organizations"), options)[0]
      org = Organization.new(attrs)
      org.unicorn = self
      org
    end

  end
end
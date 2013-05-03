module Learndot

  # Wrapper for the unicorn api
  class Unicorn

    include HTTParty
    format :json

    attr_accessor :learndot_url, :api_key

    def initialize(params = {})
      @learndot_url = params[:learndot_url] || "#{params[:learndot_name]}.learndot.com"
      @api_key= params[:api_key]
      self.class.base_uri "https://#{@learndot_url}/api"
    end

    def options
      {
          :headers => {
              'Authorization' => "learndotApiKey=#{@api_key}"
          }
      }
    end

    def get(url, options = self.options)
      self.class.get(url, options)
    end

    def post(url, record, options = self.options)
      options[:body] = record.as_json(root: false)
      self.class.post(url, options)
    end

    def handle_response(response)
      case response.code
        when 401
          raise Errors::BadApiKeyError, 'You\'re API key appears to be invalid'
        when 404
          raise Errors::NotFoundError, 'That record is no where to be found'
        when 500...600
          puts "ZOMG ERROR #{response.code}"
      end
    end

    def organization
      response = get("/organizations")
      handle_response(response)
      org = Records::Organization.new(response[0])
      org.unicorn = self

      org
    end

  end
end
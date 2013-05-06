module Learndot

  # Wrapper for the unicorn api
  class Unicorn

    include HTTParty
    persistent_connection_adapter
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
              'Authorization' => "learndotApiKey=#{@api_key}",
              'Content-Type' => 'application/json'
          }
      }
    end

    def get(url, options = self.options)
      handle_response_code(self.class.get(url, options))
    end

    def post(record, options = self.options)
      self.class.post(record.path, :body => record.as_json(root: false).to_json, :headers => options[:headers])
    end

    def put(record, options = self.options)
      self.class.put(record.path, :body => record.as_json(root: false).to_json, :headers => options[:headers])
    end

    def delete(record, options = self.options)
      self.class.delete(record.path, :headers => options[:headers])
    end

    def handle_response_code(response)
      case response.code
        when 401
          raise Errors::BadApiKeyError, 'Your API key appears to be invalid'
        when 403
          raise Errors::NotAuthorizedError, 'You are not authorized to perform that action'
        when 404
          raise Errors::NotFoundError, 'That record is no where to be found'
        when 500...600
          raise Errors::BadRequestError, 'Your request was improperly formatted'
      end

      response
    end

    # Gets the organization associated with this Unicorn instance
    #
    # @return [Organization] - the organization that maps to the provided API key
    def organization
      Records::Organization.find(self, :single => true)
    end

  end
end
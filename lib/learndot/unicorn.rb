module Learndot

  # Wrapper for the unicorn api
  class Unicorn

    include HTTParty
    persistent_connection_adapter
    format :json

    attr_accessor :learndot_url, :api_key

    def initialize(params = {})
      local = params[:local]

      @learndot_url = !local ? params[:learndot_url] || "#{params[:learndot_name]}.learndot.com" : 'localhost:8080'
      @api_key= local ? 'learndot' : params[:api_key]
      @protocol = local ? 'http' : 'https'
      postfix = local ? '' : 'api'

      self.class.base_uri "#{@protocol}://#{@learndot_url}/#{postfix}"
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

    def post_record(record, options =self.options)
      self.post(record.path, record.as_json(root: false), options)
    end

    def post(path, body, options = self.options)
      self.class.post(path, :body => body.to_json, :headers => options[:headers])
    end

    def put_record(record, options =self.options)
      self.put(record.path, record.as_json(root: false), options)
    end

    def put(path, body, options = self.options)
      self.class.put(path, :body => body.to_json, :headers => options[:headers])
    end

    def delete_record(record, options = self.options)
      self.delete(record.path, :headers => options[:headers])
    end

    def delete(path, options = self.options)
      self.class.delete(path, :headers => options[:headers])
    end

    def handle_response_code(response)
      case response.code
        when 500
          raise Errors::BadRequestError, 'Your request was improperly formatted'
        when 401
          raise Errors::BadApiKeyError, 'Your API key appears to be invalid'
        when 403
          raise Errors::NotAuthorizedError, 'You are not authorized to perform that action'
        when 404
          raise Errors::NotFoundError, 'That record is no where to be found'
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
require 'json'      

module Learndot

  # Wrapper for the unicorn api
  class Unicorn
    attr_accessor :learndot_url, :api_key

    def initialize(params = {})
      local = params[:local]
      @learndot_url = !local ? params[:learndot_url] || "#{params[:learndot_name]}.learndot.com" : 'crazyhorse.learndot.com'
      @api_key= local ? 'learndot' : params[:api_key]
    end

    def options
      {
          :headers => {
              'Authorization' => "learndotApiKey=#{@api_key}",
              'Content-Type' => 'application/json'
          }
      }
    end

    def get(path, options = self.options)
      response = HTTParty.get(uri(path), options)
      handle_response(response)
    end

    def post_record(record, options =self.options)
      body = record.as_json(root: false).to_json

      opts =  {
        :body => body,
        :headers => options[:headers]
      }

      response = HTTParty.post(uri(record.path), opts)
      handle_response(response)
    end

    def post(path, body, options = self.options)
      opts =  {
        :body => body.to_json,
        :headers => options[:headers]
      }

      response = HTTParty.post(uri(path), opts)
      handle_response(response)
    end

    def put_record(record, options =self.options)
      response = HTTParty.put(uri(record.path), record.as_json(root: false), options)
      handle_response(response)
    end

    def put(path, body, options = self.options)
      response = HTTParty.put(uri(path), :body => body.to_json, :headers => options[:headers])
      handle_response(response)
    end

    def delete_record(record, options = self.options)
      response = HTTParty.delete(uri(record.path), :headers => options[:headers])
      handle_response(response)
    end

    def delete(path, options = self.options)
      response = HTTParty.delete(uri(path), :headers => options[:headers])
      handle_response(response)
    end

    def handle_response(response)
      handle_response_code(response)

      JSON.parse(response.body)
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
        when 422
          raise Errors::UnprocessableEntityException, 'That record is no where to be found'
      end

      response
    end

    # Gets the organization associated with this Unicorn instance
    #
    # @return [Organization] - the organization that maps to the provided API key
    def organization
      Records::Organization.find(self, :single => true)
    end

    private

    def uri(path) 
      ret = "https://#{learndot_url}/api#{path}"
      puts ret
      ret 
    end 
  end
end
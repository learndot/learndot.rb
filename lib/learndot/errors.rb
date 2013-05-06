module Learndot
  module Errors
    autoload :BadApiKeyError, 'learndot/errors/bad_api_key_error'
    autoload :BadRequestError, 'learndot/errors/bad_request_error'
    autoload :NotAuthorizedError, 'learndot/errors/not_authorized_error'
    autoload :NotFoundError, 'learndot/errors/not_found_error'
  end
end

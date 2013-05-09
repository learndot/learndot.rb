module Learndot
  module Records
    class User < UnicornRecord
      unicorn_attr :first_name, :last_name, :email, :password

      def accept_terms!
        unicorn.put("/acceptedTerms/#{id}", {})
      end
    end
  end
end


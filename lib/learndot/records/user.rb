module Learndot
  module Records
    class User < UnicornRecord
      unicorn_attr :first_name, :last_name, :email, :password

    end
  end
end


module Learndot
  module Records
    class Course < UnicornRecord
      unicorn_attr :name, :description,

      validates_presence_of :name, :description
    end
  end
end
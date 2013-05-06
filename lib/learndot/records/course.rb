module Learndot
  module Records
    class Course < UnicornRecord
      unicorn_attr :name, :description, :organization_id, :custom_order

      validates_presence_of :name, :description
    end
  end
end
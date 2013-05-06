module Learndot
  module Records
    class Course < UnicornRecord
      unicorn_attr :name, :description, :learning_objective, :organization_id, :custom_order
      unicorn_belongs_to :organization
      unicorn_has_many :concepts

      validates_presence_of :name, :description
    end
  end
end
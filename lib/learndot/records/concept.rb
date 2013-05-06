module Learndot
  module Records
    class Concept < UnicornRecord
      unicorn_attr :name, :description, :courses
      unicorn_has_many :course

      validates_presence_of :name, :description

      def course
        self.courses.first
      end
    end
  end
end
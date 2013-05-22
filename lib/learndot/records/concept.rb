module Learndot
  module Records
    class Concept < UnicornRecord
      unicorn_attr :name, :description, :courses, :learning_objective, :is_exam, :self_assessment_responses
      unicorn_has_many :course
      unicorn_has_many :self_assessment_responses

      validates_presence_of :name, :description

      def course
        self.courses.first
      end
    end
  end
end
require 'json'

module Learndot
  module Records
    class Assessment < UnicornRecord
      unicorn_attr :name, :passing_grade, :is_test, :description, :success_message, :failure_message, :concept_id

      unicorn_belongs_to :concept
      unicorn_has_many :free_form_questions
      unicorn_has_many :self_assessment_responses
      unicorn_has_many :multiple_choice_questions
    end
  end
end

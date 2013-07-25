module Learndot
  module Records
    class MultipleChoiceQuestion < UnicornRecord
      unicorn_attr :question, :assessment_id
      unicorn_belongs_to :assessment

      unicorn_has_many :multiple_choice_question_choices, :as => :choices
    end

    class MultipleChoiceQuestionChoice < UnicornRecord
      unicorn_attr :answer, :is_correct, :justification, :multiple_choice_question_id

      unicorn_belongs_to :multiple_choice_question
    end
  end
end

module Learndot
  module Records
    autoload :BaseRecord, 'learndot/records/base_record'
    autoload :UnicornRecord, 'learndot/records/unicorn_record'

    autoload :Concept, 'learndot/records/concept'
    autoload :Course, 'learndot/records/course'
    autoload :Organization, 'learndot/records/organization'
    autoload :User, 'learndot/records/user'

    # Assessment Records
    autoload :Assessment, 'learndot/records/assessment'
    autoload :MultipleChoiceQuestion, 'learndot/records/multiple_choice_question'
    autoload :MultipleChoiceQuestionChoice, 'learndot/records/multiple_choice_question'
    autoload :FreeFormQuestion, 'learndot/records/free_form_question'
    autoload :SelfAssessmentResponse, 'learndot/records/self_assessment_response'
  end
end

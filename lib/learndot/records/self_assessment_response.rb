module Learndot
  module Records
    class SelfAssessmentResponse < UnicornRecord
      unicorn_attr :rating, :concept_id, :user_id
      unicorn_belongs_to :concept

      validates_presence_of :rating
    end
  end
end
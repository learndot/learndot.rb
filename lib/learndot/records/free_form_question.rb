module Learndot
  module Records
    class FreeFormQuestion < UnicornRecord
      unicorn_attr :question, :concept_id, :assessment_id, :response_ids, :consideration

      unicorn_belongs_to :concept
      unicorn_belongs_to :assessment

      validates_presence_of :question
    end
  end
end
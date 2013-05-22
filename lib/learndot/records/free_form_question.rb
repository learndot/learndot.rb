module Learndot
  module Records
    class FreeFormQuestion < UnicornRecord
      unicorn_attr :question, :concept_id, :response_ids
      unicorn_belongs_to :concept

      validates_presence_of :question
    end
  end
end
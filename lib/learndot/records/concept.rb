module Learndot
  module Records
    class Concept < UnicornRecord
      unicorn_attr :name, :description, :courses, :assessments, :learning_objective, :is_exam, :self_assessment_responses
      unicorn_has_many :courses
      unicorn_has_many :assessments

      validates_presence_of :name, :description

      def course
        courses.first
      end

      def assessment
        assessments.first
      end

      def describe_assessment_as_json

        buffer = {}
        ffqs = []
        mcqs = []

        buffer["conceptId"] = id

        assessment.multiple_choice_questions.each do |question|
          attrs = question.attributes.clone
          attrs.delete("errors")
          attrs.delete("createdOn")
          attrs.delete("updatedOn")

          choices = []

          question.choices.each do |choice|
            attrs1 = choice.attributes.clone
            attrs1.delete("errors")
            attrs1.delete("multipleChoiceQuestionId")
            attrs1.delete("createdOn")
            attrs1.delete("updatedOn")

            choices << attrs1
          end

          attrs["choices"] = choices

          mcqs << attrs
        end


        assessment.free_form_questions.each do |question|
          attrs = question.attributes.clone
          attrs.delete("errors")
          attrs.delete("createdOn")
          attrs.delete("updatedOn")
          attrs.delete("responseIds")

          if !attrs.has_key? "consideration"
            attrs["consideration"] = ""
          end

          ffqs << attrs
        end

        buffer["multipleChoiceQuestions"] = mcqs
        buffer["freeFormQuestions"] = ffqs

        JSON.pretty_generate(buffer)
      end

      def self.from_file(unicorn, file)
        obj = JSON.parse(file)

        concept = find unicorn, :id => obj["conceptId"]
        assessment = concept.assessment

        mcqs = obj["multipleChoiceQuestions"]
        ffqs = obj["freeFormQuestions"]

        mcqs.each do |question|
          if question.has_key? "id"
            mcq = MultipleChoiceQuestion.find unicorn, :id => question["id"]
            puts "Updating Mutiple Choice Question [#{mcq.id}]"
            mcq.question = question["question"]
          else
            puts "Creating new Mutple Choice Question #{question["question"]}"
            mcq = MultipleChoiceQuestion.new unicorn, :question => question["question"]
            mcq.assessment = assessment
          end

          mcq.save!
          puts "Saved - #{mcq.id}"

          question["choices"].each do |choice|
            if choice.has_key? "id"
              puts "Updating Multiple Choice Question Choice #{choice["id"]}"
              mcqc = MultipleChoiceQuestionChoice.find unicorn, :id => choice["id"]
              mcqc.answer = choice["answer"]
              mcqc.is_correct = choice["isCorrect"]
              mcqc.justification = choice["justification"]
            else
              puts "Creating new Multiple Choice Choice #{choice["answer"]}"
              mcqc = MultipleChoiceQuestionChoice.new unicorn, :answer => choice["answer"], :is_correct => choice["isCorrect"], :justification => choice["justification"]
              mcqc.multiple_choice_question = mcq
            end

            mcqc.save!
            puts "Saved - #{mcqc.id}"
          end
        end

        ffqs.each do |question|

          if question.has_key? "id"
            ffq = FreeFormQuestion.find unicorn, :id => question["id"]
            puts "Updating Free Form Question [#{ffq.id}]"
            ffq.question = question["question"]
            p "Setting Consideration #{question["consideration"]}"
            ffq.consideration = question["consideration"]
          else
            puts "Creating new Free Form Question #{question["question"]}"
            ffq = FreeFormQuestion.new unicorn, :question => question["question"], :consideration => question["consideration"]
          end

          ffq.assessment = assessment
          ffq.concept = concept
          ffq.save!
        end

        concept
      end
    end
  end
end
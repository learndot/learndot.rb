module Learndot
  module Records
    class Course < UnicornRecord
      unicorn_attr :name, :description, :learning_objective, :organization_id, :custom_order, :students, :instructors, :free_form_questions

      unicorn_belongs_to :organization
      unicorn_has_many :concepts
      unicorn_has_many :free_form_questions
      unicorn_has_many :users, :as => :students
      #unicorn_has_many :users, :as => :instructors

      validates_presence_of :name, :description

      def custom_order
        @custom_order || false
      end

      def add_student(user)
        unicorn.post('/courseRole', {userId: user.id, courseId: self.id, courseRole: 'Student'})
      end

      def add_instructor(user)
        unicorn.post('/courseRole', {userId: user.id, courseId: self.id, courseRole: 'Instructor'})
      end
    end
  end
end
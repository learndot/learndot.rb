module Learndot
  module Records
    class UnicornRecord < BaseRecord

      attr_accessor :unicorn
      unicorn_attr :id, :created_on, :updated_on

      def self.find(id)
        self.new(get("/#{name.downcase.pluralize}"))
      end

      def save
      end

    end
  end
end

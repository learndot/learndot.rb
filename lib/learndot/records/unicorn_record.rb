module Learndot
  module Records
    class UnicornRecord < BaseRecord

      attr_accessor :unicorn, :persisted
      unicorn_attr :id, :created_on, :updated_on

      def initialize(unicorn, params = {})
        super(params)

        @unicorn = unicorn
      end

      def persisted?
        @persisted
      end

      def save
        if valid?
          if persisted?
            self.attributes = unicorn.put(self)
          else
            self.attributes = unicorn.post(self)
          end
        end

        self
      end

      def destroy!
        if persisted?
          unicorn.delete(self)
        end
      end

      def path
        self.class.path + if persisted? then
                            "/#{id}"
                          else
                            ''
                          end
      end

      ## Class Methods

      def self.path
        '/' + name.demodulize.downcase.pluralize
      end

      def self.find(unicorn, params = {})
        result = nil

        if params.has_key? :id
          result = self.new(unicorn, unicorn.get("/#{self.path}/#{params[:id]}"))
          result.persisted = true
        else
          result = []

          unicorn.get("/#{self.path}").each do |record|
            local_record = self.new(unicorn, record)
            local_record.persisted = true
            result.push(local_record)
          end

          result = result[0] if params.has_key? :single
        end

        result
      end
    end
  end
end

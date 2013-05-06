module Learndot
  module Records
    class UnicornRecord < BaseRecord

      attr_accessor :unicorn, :persisted, :destroyed
      unicorn_attr :id, :created_on, :updated_on

      def initialize(unicorn, params = {})
        super(params)

        @unicorn = unicorn
      end

      def persisted?
        @persisted
      end

      def destroyed?
        @destroyed
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

      def save!
        save
      end

      def destroy!
        if persisted?
          unicorn.delete(self)
          self.destroyed = true
        end
      end

      def path(query=nil)
        path = self.class.path(query)
        path += "/#{id}" unless not persisted?

        path
      end

      ## Class Methods

      def self.path(query=nil)
        path = "/#{name.demodulize.downcase.pluralize}"
        path += "?#{query}" unless query.nil?

        path
      end

      def self.find(unicorn, params = {})
        result = nil

        if params.has_key? :id
          result = self.new(unicorn, unicorn.get("#{self.path}/#{params[:id]}"))
          result.persisted = true
        else
          result = []

          unicorn.get(self.path(params[:query])).each do |record|
            local_record = self.new(unicorn, record)
            local_record.persisted = true
            result.push(local_record)
          end

          result = result[0] if params.has_key? :single
        end

        result
      end

      def self.unicorn_has_many(*args)
        args.each do |arg|
          self.send(:define_method, arg) do
            Learndot::Records.const_get(arg.to_s.singularize.classify).send(:find, self.unicorn, :query => "#{self.class.name.demodulize.downcase}Id=#{self.id}")
          end
        end
      end

      def self.unicorn_belongs_to(*args)
        args.each do |arg|
          self.send(:define_method, arg) do
            Learndot::Records.const_get(arg.to_s.classify).send(:find, self.unicorn, :id => self.send("#{arg}_id"))
          end
        end

        args.each do |arg|
          self.send(:define_method, "#{arg}=") do |value|
            self.send("#{arg}_id=",value.id)
          end
        end
      end
    end
  end
end

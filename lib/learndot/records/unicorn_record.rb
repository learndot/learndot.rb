module Learndot
  module Records
    class UnicornRecord < BaseRecord

      attr_accessor :unicorn, :persisted, :destroyed
      unicorn_attr :id, :created_on, :updated_on

      def initialize(unicorn, params = {})
        super(params)

        @unicorn = unicorn
      end

      # Whether or not this record has been persisted, or only created via Record.new
      #
      # @return [Boolean] whether this record has been persisted
      def persisted?
        @persisted
      end

      # Whether or not this record has been destroyed
      #
      # @return [Boolean] whether this record has been destroyed or not
      def destroyed?
        @destroyed
      end


      # Saves this object, either by updating it if it's already been save, or by creating it if it has not yet been
      # saved.
      #
      # @return [self]
      def save
        if valid?
          if persisted?
            self.attributes = unicorn.put_record(self)
          else
            self.attributes = unicorn.post_record(self)
          end
        end

        self
      end

      # Saves this object
      def save!
        save
      end

      # Destroys  this object
      #
      def destroy!
        if persisted?
          unicorn.delete_record(self)
          self.destroyed = true
        end
      end

      # Generates the path for this type of record, if the record has been persisted before it will include the
      # id of the record, otherwise it will be the pluralized form of the class name.
      #
      # @param query [String] an option query string to append to the path
      # @return [String] the path for this instance
      def path(query=nil)
        path = self.class.path(query)
        path += "/#{id}" unless not persisted?

        path
      end

      ## Class Methods

      # The Path for this record type
      #
      # @param query [String] an optional query string to be appended to the path
      # @return [String] the path for this particular record
      def self.path(query=nil)
        path = "/#{name.demodulize.downcase.pluralize}"
        path += "?#{query}" unless query.nil?

        path
      end

      # Finds a record or records of this particular class
      #
      # @param unicorn [Unicorn] required for attaching the API key
      # @param opts [Hash] addition parameters which modify which query is executed,
      #
      # @option opts [Boolean] :single => true, will cause a get to /plural_record_name and return the first result
      # @option opts [String] :query => 'someQuery', will append a query parameter to which ever url is generated
      # @option opts [Integer]:id => some_id, will cause a get to /plural_record_name/:some_id with the expectation that the result will
      # contain only one record
      #
      def self.find(unicorn, opts = {})
        result = nil

        if opts.has_key? :id
          result = self.new(unicorn, unicorn.get("#{self.path}/#{opts[:id]}"))
          result.persisted = true
        else
          result = []

          unicorn.get(self.path(opts[:query])).each do |record|
            local_record = self.new(unicorn, record)
            local_record.persisted = true
            result.push(local_record)
          end

          result = result[0] if opts.has_key? :single
        end

        result
      end

      # Adds methods to the class for accessing records owned by this record
      #
      # @param arg [Symbol] the plural name of the record(s) which are owned by this record
      # @param opts [Hash] additional options for configuring the accessor method
      # @option opts [Symbol] :as the name of the method for accessing this relationship
      def self.unicorn_has_many(arg, opts = {})
        self.send(:define_method, opts[:as] || arg) do
          Learndot::Records.const_get(arg.to_s.singularize.classify).send(:find, self.unicorn, :query => "#{self.class.name.demodulize.downcase}Id=#{self.id}")
        end
      end

      # Adds accessor methods to the class for defining a record which owns this record
      #
      # @param arg [Symbol] the singular name of the record which owns this record
      # @param params [Hash] additional parameters
      def self.unicorn_belongs_to(arg, opts = {})

        self.send(:define_method, arg) do
          Learndot::Records.const_get(arg.to_s.classify).send(:find, self.unicorn, :id => self.send("#{arg}_id"))
        end

        self.send(:define_method, "#{arg}=") do |value|
          self.send("#{arg}_id=", value.id)
        end
      end
    end
  end
end

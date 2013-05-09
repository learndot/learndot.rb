require 'active_model'

module Learndot
  module Records

    # As the learndot api uses java style camel case for the json keys
    # this class acts to translate between the two styles.
    class BaseRecord

      include ActiveModel::Validations
      include ActiveModel::Serialization
      include ActiveModel::Serializers::JSON
      include ActiveModel::Serializers::Xml

      attr_accessor :attribute

      def initialize(attributes = {})
        attrs = {}
        attributes.each do |key, value|
          attrs[key.to_s.camelize(:lower)] = value
        end

        self.attributes = attrs
      end

      def read_attribute_for_validation(key)
        attributes[key.to_s.camelize(:lower)]
      end

      def read_attribute_for_serialization(key)
        attributes[key]
      end

      def attributes
        @attributes ||= {}
      end

      def attributes=(attributes)
        @attributes = attributes
      end

      def self.unicorn_attr(*args)
        args.each do |arg|
          self.send(:define_method, arg) do
            attributes[arg.to_s.camelize(:lower)]
          end

          self.send(:define_method, "#{arg}=") do |value|
            attributes[arg.to_s.camelize(:lower)] = value
          end
        end
      end
    end

  end
end
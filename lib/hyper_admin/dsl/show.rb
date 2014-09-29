module HyperAdmin
  module DSL
    class Show

      def initialize(resource_class)
        @resource_class = resource_class
        @rows = []
      end

      def row(attribute, type: infer_type(attribute), human: human_name(attribute))
        @rows << { attribute: attribute, type: type, human: human }
      end

      private

      def infer_type(attribute)
        @resource_class.columns_hash[attribute.to_s].type
      end

      def human_name(attribute)
        @resource_class.human_attribute_name attribute
      end

    end
  end
end

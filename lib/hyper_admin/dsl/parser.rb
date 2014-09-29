module HyperAdmin
  module DSL
    class Parser

      def initialize(resource_class)
        @resource_class = resource_class
        @config = { }
      end

      def parse(&block)
        return unless block_given?

        instance_exec(&block)

        @config
      end

      def show(&block)
        return unless block_given?

        dsl = HyperAdmin::DSL::Show.new @resource_class
        
        @config[:show_config] = dsl.instance_exec(&block)
      end

      def index(&block)
        return unless block_given?

        dsl = HyperAdmin::DSL::Index.new @resource_class
        @config[:index_config] = dsl.instance_exec(&block)
      end

      def form(&block)
        return unless block_given?

        dsl = HyperAdmin::DSL::Form.new @resource_class
        @config[:form_config] = dsl.instance_exec(&block)
      end

    end
  end
end

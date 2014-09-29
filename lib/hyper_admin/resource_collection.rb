require 'hyper_admin/resource'
require 'hyper_admin/dsl'

module HyperAdmin
  class ResourceCollection
    attr_reader :resources

    def initialize
      @resources = {}
    end

    def add(resource_class, &block)
      config = config_from_registration_block(resource_class, &block)

      resource = Resource.new(resource_class, config)
      @resources[resource_class.model_name] = resource

      resource
    end

    def each(&block)
      @resources.values.each(&block)
    end

    private

    def config_from_registration_block(resource_class, &block)
      return unless block_given?

      parser = HyperAdmin::DSL::Parser.new(resource_class)
      parser.parse(&block)
    end
  end
end

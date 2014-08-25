require 'hyper_admin/resource'

module HyperAdmin
  class ResourceCollection
    attr_reader :resources

    def initialize
      @resources = {}
    end

    def add(resource_class)
      resource = Resource.new(resource_class)
      @resources[resource_class.model_name] = resource

      resource
    end

    def each(&block)
      @resources.values.each(&block)
    end
  end
end

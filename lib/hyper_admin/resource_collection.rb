require 'hyper_admin/resource'

module HyperAdmin
  class ResourceCollection
    attr_reader :resources

    def initialize
      @resources = {}
    end

    def add(resource_class)
      @resources[resource_class.model_name] = Resource.new(resource_class)
    end
  end
end

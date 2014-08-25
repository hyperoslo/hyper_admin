module HyperAdmin
  class Resource
    attr_reader :resource_class

    def initialize(resource_class)
      @resource_class = resource_class
    end
  end
end

module HyperAdmin
  class Resource
    attr_reader :resource_class, :config

    def initialize(resource_class, config)
      @resource_class = resource_class
      @config = config
    end

    def resource_name
      @resource_class.model_name
    end

    def controller_name
      "#{resource_name.plural.camelize}Controller"
    end

    def show_config
      @config[:show_config] if @config
    end

    def index_config
      @config[:index_config] if @config
    end

    def form_config
      @config[:form_config] if @config
    end
  end
end

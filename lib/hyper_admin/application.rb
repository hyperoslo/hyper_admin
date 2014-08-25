require 'hyper_admin/resource_collection'
require 'hyper_admin/router'

module HyperAdmin
  class Application
    attr_reader :resources

    def setup
      @resources = ResourceCollection.new

      prevent_rails_autoloading_load_paths
    end

    def register(resource_class)
      @resources.add resource_class
    end

    def routes(rails_router)
      load_files

      router.apply rails_router
    end

    private

    def load_paths
      [File.expand_path('app/admin', Rails.root)]
    end

    def router
      @router ||= Router.new(self)
    end

    def admin_files
      load_paths.map do |path|
        Dir["#{path}/**/*.rb"]
      end.flatten
    end

    def load_files
      admin_files.each { |file| load file }
    end

    def prevent_rails_autoloading_load_paths
      ActiveSupport::Dependencies.autoload_paths -= load_paths
      Rails.application.config.eager_load_paths  -= load_paths
    end
  end
end

module HyperAdmin
  class Router
    def initialize(application)
      @application = application
    end

    def apply(rails_router)
      define_resource_routes rails_router
    end

    private

    def define_resource_routes(router)
      router.instance_exec @application.resources do |_resources|
        self.namespace 'admin' do
          _resources.each do |resource|
            self.resources resource.resource_name.route_key
          end
        end
      end
    end
  end
end

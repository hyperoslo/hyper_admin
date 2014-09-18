module HyperAdmin
  class ResourceClassesController < ApplicationController
    respond_to :json

    def index
      collection = ::HyperAdmin.application.resources
      @resource_classes = collection.resources.values.map(&:resource_class)

      respond_with @resource_classes
    end

    def show
      collection = ::HyperAdmin.application.resources
      resource_classes = collection.resources.values.map(&:resource_class)
      @resource_class = resource_classes.find { |c| c.model_name.route_key == params[:id] }

      respond_with @resource_class
    end
  end
end

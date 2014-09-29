module HyperAdmin
  class ResourceClassesController < ApplicationController
    respond_to :json

    def index
      collection = ::HyperAdmin.application.resources
      @resource_classes = collection.resources.values

      respond_with @resource_classes
    end

    def show
      collection = ::HyperAdmin.application.resources
      resource_classes = collection.resources.values

      @resource_class = resource_classes.find do |c|
        c.resource_class.model_name.route_key == params[:id]
      end

      fail ActiveRecord::RecordNotFound unless @resource_class

      respond_with @resource_class
    end
  end
end

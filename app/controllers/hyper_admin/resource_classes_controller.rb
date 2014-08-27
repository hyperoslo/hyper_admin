module HyperAdmin
  class ResourceClassesController < ApplicationController
    respond_to :json

    def index
      collection = ::HyperAdmin.application.resources
      @resource_classes = collection.resources.values.map(&:resource_class)

      respond_with @resource_classes
    end
  end
end

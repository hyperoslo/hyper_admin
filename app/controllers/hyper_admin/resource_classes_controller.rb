module HyperAdmin
  class ResourceClassesController < ApplicationController
    respond_to :json

    def index
      collection = ::HyperAdmin.application.resources
      @resource_classes = collection.resources.values

      respond_with @resource_classes
    end

    def show
      @resource_class = find_resource_class
      respond_with @resource_class
    end

    def count
      count = find_resource_class.resource_class.count
      page_count = count / 25

      page_count = 1 if page_count == 0

      @pages = (1..page_count).to_a
    end

    private

    def find_resource_class
      collection = ::HyperAdmin.application.resources
      resource_classes = collection.resources.values

      id = params[:id]
      resource_class = resource_classes.find do |c|
        c.resource_class.model_name.route_key == id
      end

      fail ActiveRecord::RecordNotFound unless resource_class

      resource_class
    end
  end
end

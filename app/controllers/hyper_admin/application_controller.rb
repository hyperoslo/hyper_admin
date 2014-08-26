module HyperAdmin
  class ApplicationController < ActionController::Base
    before_action :load_all_resource_classes

    protected

    def load_all_resource_classes
      collection = ::HyperAdmin.application.resources
      @resource_classes = collection.resources.values.map(&:resource_class)
    end
  end
end

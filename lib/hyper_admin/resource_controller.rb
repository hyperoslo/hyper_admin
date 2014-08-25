module HyperAdmin
  class ResourceController < ActionController::Base
    before_action :set_resource_class

    def index
      @resources = resource_class.all
      render 'admin/resources/index'
    end

    def show
      @resource = resource
      render 'admin/resources/show'
    end

    def new
      @resource = resource
      render 'admin/resources/new'
    end

    def edit
      @resource = resource
      render 'admin/resources/edit'
    end

    def create
    end

    def update
    end

    def destroy
    end

    def resource
      resource_class.find params[:id]
    end

    def resource_class
      raise "This method must be overridden"
    end

    protected

    def set_resource_class
      @resource_class = resource_class
    end
  end
end

module HyperAdmin
  class ResourceController < ApplicationController
    before_action :set_resource_class
    before_action :permit_params, only: [ :create, :update ]

    before_action do
      self.class.layout ->{ request.xhr? ? false : 'hyper_admin/application' }
    end

    def index
      @resources = resource_class.all
      render 'admin/resources/index'
    end

    def show
      @resource = resource
      render 'admin/resources/show'
    end

    def new
      @resource = resource_class.new
      @attributes = @resource.attributes.delete_if do |k, v|
        k.to_sym.in? [ :id, :created_at, :updated_at ]
      end
      render 'admin/resources/new'
    end

    def edit
      @resource = resource
      @attributes = @resource.attributes.delete_if do |k, v|
        k.to_sym.in? [ :id, :created_at, :updated_at ]
      end
      render 'admin/resources/edit'
    end

    def create
      @resource = @resource_class.new params[@resource_class.model_name.param_key]

      if @resource.save
        render json: @resource
      else
        render json: @resource.errors, status: 422
      end
    end

    def update
      @resource = @resource_class.find params[:id]

      if @resource.update params[@resource_class.model_name.param_key]
        render json: @resource
      else
        render json: @resource.errors, status: 422
      end
    end

    def destroy
      @resource = @resource_class.find params[:id]

      @resource.destroy

      flash[:success] = "Successfully destroyed #{@resource_class.model_name.singular}."
      respond_with @resource
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

    def permit_params
      params.permit!
    end
  end
end

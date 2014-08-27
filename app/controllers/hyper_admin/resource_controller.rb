module HyperAdmin
  class ResourceController < ApplicationController
    before_action :set_resource_class
    before_action :permit_params, only: [ :create, :update ]

    def index
      @resources = resource_class.all
      render 'admin/resources/index', layout: layout
    end

    def show
      @resource = resource
      render 'admin/resources/show', layout: layout
    end

    def new
      @resource = resource_class.new
      @attributes = @resource.attributes.delete_if do |k, v|
        k.to_sym.in? [ :id, :created_at, :updated_at ]
      end
      render 'admin/resources/new', layout: layout
    end

    def edit
      @resource = resource
      @attributes = @resource.attributes.delete_if do |k, v|
        k.to_sym.in? [ :id, :created_at, :updated_at ]
      end
      render 'admin/resources/edit', layout: layout
    end

    def create
      @resource = @resource_class.new params[@resource_class.model_name.param_key]

      if @resource.save
        flash[:success] = "Successfully created #{@resource_class.model_name.singular}."
        redirect_to [ :admin, @resource ]
      else
        flash.now[:danger] = "Failed to create #{@resource_class.model_name.singular}."
        render "admin/resources/new", layout: layout
      end
    end

    def update
      @resource = @resource_class.find params[:id]

      if @resource.update params[@resource_class.model_name.param_key]
        flash[:success] = "Successfully updated #{@resource_class.model_name.singular}."
        redirect_to [ :admin, @resource ]
      else
        flash.now[:danger] = "Failed to update #{@resource_class.model_name.singular}."
        render "admin/resources/edit", layout: layout
      end
    end

    def destroy
      @resource = @resource_class.find params[:id]

      @resource.destroy

      flash[:success] = "Successfully destroyed #{@resource_class.model_name.singular}."
      redirect_to [ :admin, @resource_class ]
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

    def layout
      'hyper_admin/application'
    end
  end
end

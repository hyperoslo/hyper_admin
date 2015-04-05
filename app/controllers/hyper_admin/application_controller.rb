module HyperAdmin
  class ApplicationController < ActionController::Base
    before_action :set_layout

    def dashboard

    end

    protected

    def set_layout
      self.class.layout ->{ request.xhr? ? false : 'hyper_admin/application' }
    end
  end
end

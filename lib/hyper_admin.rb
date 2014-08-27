require 'angularjs-rails'
require 'jquery-rails'

require 'hyper_admin/engine'
require 'hyper_admin/application'

module HyperAdmin
  class << self

    delegate :register, to: :application
    delegate :routes,   to: :application
    delegate :setup,    to: :application

    def application
      @application ||= HyperAdmin::Application.new
    end

    def config
      application.setup
    end

  end
end

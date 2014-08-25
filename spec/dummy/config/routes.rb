Rails.application.routes.draw do
  mount HyperAdmin::Engine, at: '/admin'
end

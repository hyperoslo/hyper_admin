HyperAdmin::Engine.routes.draw do
  resources :resource_classes, only: :index
end

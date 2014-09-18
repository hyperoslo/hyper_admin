HyperAdmin::Engine.routes.draw do
  resources :resource_classes, only: %i(index show)
end

HyperAdmin::Engine.routes.draw do
  controller(:application) { root to: :dashboard }

  resources :resource_classes, only: %i(index show)
end

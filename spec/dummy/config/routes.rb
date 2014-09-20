Rails.application.routes.draw do
  HyperAdmin.routes self

  mount HyperAdmin::Engine, at: '/admin'
end

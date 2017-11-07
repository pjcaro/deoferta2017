Rails.application.routes.draw do
  resources :productos
  root 'productos#search'

  get 'productos/:id/historial', to: 'productos#historial', as: 'historial_producto'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

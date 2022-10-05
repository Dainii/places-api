Rails.application.routes.draw do
  resources :canvas
  post '/canvas/:id', to: 'canvas#update_canva_boxes'
end

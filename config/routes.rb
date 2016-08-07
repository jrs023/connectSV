Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#index'
  
  namespace :api do
      resources :sku, :defaults => { :format => 'json' }
  end
  
end

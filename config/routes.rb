Rails.application.routes.draw do
  resources :kinds

  api_version(:module => 'v1', :path => { :value => 'v1'}) do
    resources :notebooks do
      resource :kind, only: [:show]
      resource :kind, only: [:show], path: 'relationships/kind'
  
      resource :phones, only: [:show]
      resource :phones, only: [:show], path: 'relationships/phones'
  
      resource :address, only: [:show, :update, :create, :destroy]
      resource :address, only: [:show, :update, :create, :destroy], path: 'relationships/address'
    end
  end

  api_version(:module => 'v2', :path => { :value => 'v2'}) do
    resources :notebooks do
      resource :kind, only: [:show]
      resource :kind, only: [:show], path: 'relationships/kind'
  
      resource :phones, only: [:show]
      resource :phones, only: [:show], path: 'relationships/phones'
  
      resource :address, only: [:show, :update, :create, :destroy]
      resource :address, only: [:show, :update, :create, :destroy], path: 'relationships/address'
    end
  end
end

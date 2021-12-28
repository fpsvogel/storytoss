Rails.application.routes.draw do
  root 'stories#index', as: :stories_index

  get  'register', to: 'users#new'
  post 'register', to: 'users#create'

  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'stories/:id', to: 'stories#show'
end

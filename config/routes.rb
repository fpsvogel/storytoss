Rails.application.routes.draw do
  root 'stories#index', as: :stories_index

  get  'register', to: 'users#new'
  post 'register', to: 'users#create'

  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'stories/:id', to: 'stories#show', as: :show_story

  post 'paragraphs/:id/continue', to: 'paragraphs#create', as: :create_paragraph
  post 'paragraphs/:id/like'   , to: 'paragraphs#like'   , as: :like_paragraph
  post 'paragraphs/:id/dislike', to: 'paragraphs#dislike', as: :dislike_paragraph
end

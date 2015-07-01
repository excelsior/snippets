Rails.application.routes.draw do
  resources :snippets, only: [:create, :new, :show]

  root to: 'snippets#index'
end

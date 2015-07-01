Rails.application.routes.draw do
  resources :snippets, only: [:create, :new]

  root to: 'snippets#index'
end

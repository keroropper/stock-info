Rails.application.routes.draw do
  get 'comments/create'
  devise_for :users
  root to: 'articles#index'
  resources :articles do
    collection do
      get 'search'
    end
    resource :likes, only: [:create, :destroy]
    resources :comments, only: :create
  end
  get 'tags/index' => 'articles#tag_index'
end

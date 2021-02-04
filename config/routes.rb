Rails.application.routes.draw do
  devise_for :users
  root to: 'articles#index'
  resources :articles do
    collection do
      get 'search'
    end
  end
  get 'tags/index' => 'articles#tag_index'
end

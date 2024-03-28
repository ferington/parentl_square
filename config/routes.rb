Rails.application.routes.draw do

  namespace :admin do
    get 'home/intex' => 'home#intex', as: 'home'
    resources :post_comments, only: [:index, :destroy]
    resources :posts, only: [:index, :destroy]
    resources :customers, only: [:index, :destroy]
  end
  
  devise_for :admin, controllers: {
    sessions: "admin/sessions",
    registrations: "admin/registrations" #sign_upに遷移しないようにするため
  }

   devise_for :customers, controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  devise_scope :customer do
    post "users/guest_sign_in", to: "user/sessions#guest_sign_in"
  end

  namespace :admin do


  end
  scope module: :user do
    root to: 'homes#top'
    get "about" => "homes#about", as:"about"
    get '/search_tag', to: 'posts#search_tag'
    get  '/customers/check' => 'customers#check'
    get "/search", to: "searches#search"
    # 論理削除用のルーティング
    patch  '/customers/withdraw' => 'customers#withdraw'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :messages, only: [:create]
    resources :rooms, only: [:create, :index, :show]
    resources :posts do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
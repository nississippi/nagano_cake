Rails.application.routes.draw do

  namespace :admin do
    get '' => 'homes#top'
    resources :items, except: [:destroy]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
  end

  scope module: :public do
    root to: "homes#top"
    get 'about' => 'homes#about', as: 'about'
    resources :addresses, except: [:new, :show]
    resources :orders, only: [:new, :create, :index, :show]
    post 'orders/confirm'
    get 'orders/complete'
    get 'customers/my_page' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    
    get 'customers/unsubscribe'
    get 'customers/withdraw'
    resources :cart_items, only: [:index, :update, :create, :destroy]
    
    resources :items, only: [:index, :show]
  end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

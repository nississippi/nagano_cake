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
    get 'orders/complete' => 'orders#complete'
    post 'orders/confirm' => 'orders#confirm'
    resources :orders, only: [:new, :create, :index, :show]
    get 'customers/my_page' => 'customers#show'
    get 'customers/information/edit' => 'customers#edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/unsubscribe'
    patch 'customers/withdraw'
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'cart_items_destroy_all'
    resources :cart_items, only: [:create, :index, :update, :create, :destroy]
    #上記２行の順番が入れ替わると、"destroy_all"というidが見つからないよ！というエラーが出る。:idを含むルートは特定のルートよりも後に書く。
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

Rails.application.routes.draw do
  # 管理者用 Devise
  devise_for :admins, path: 'admin', skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # 顧客用 Devise
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # 管理者用 namespace
  namespace :admin do
    get '/' => 'homes#top', as: :root # 管理者トップページ

    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:update]            # 注文ステータス更新
    resources :order_details, only: [:show, :update] # 製作ステータス更新
  end

  # 顧客用 Public namespace
  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"

    resources :items, only: [:index, :show]
    resources :genres, only: [:index, :show]  # ジャンル別商品一覧

    resource :customers, only: [:edit, :update] do
      get "mypage" => "customers#show"
      get "check" => "customers#check"
      patch "withdrow" => "customers#withdrow"
    end

    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete "destroy_all"
      end
    end

    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post "check"
        get "finish"
      end
    end

    resources :shipping_addresses, only: [:index, :new, :create, :edit, :update, :destroy]
  end
end

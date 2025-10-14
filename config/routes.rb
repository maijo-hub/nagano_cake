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
    # トップページ・アバウト
    root to: "homes#top"
    get "about", to: "homes#about"

    # 商品関連
    resources :items, only: [:index, :show]        # 新着商品一覧・商品詳細
    resources :genres, only: [:index, :show]       # ジャンル別商品一覧

    # 顧客関連
    get 'customers/mypage', to: 'customers#show', as: 'mypage_customers'       # マイページ
    get 'customers/check', to: 'customers#check', as: 'check_customers'       # 退会確認
    patch 'customers/withdrow', to: 'customers#withdrow', as: 'withdrow_customers' # 退会処理

    # 登録情報編集・更新
    get 'customers/information/edit', to: 'customers#edit', as: 'information_edit'
    patch 'customers/information', to: 'customers#update', as: 'information'

    # カート
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete 'destroy_all'  # カート内全削除
      end
    end

    # 注文
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post 'check'          # 注文確認
        get 'finish'          # 注文完了
      end
    end

    # 配送先
    resources :shipping_addresses, only: [:index, :new, :create, :edit, :update, :destroy]
  end
end

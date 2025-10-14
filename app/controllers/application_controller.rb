class ApplicationController < ActionController::Base
  # ログイン後の遷移先
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_root_path # 管理者は注文履歴一覧へ
    when Customer
      if session[:previous_action] == "sign_up"
        session[:previous_action] = nil # 一度使ったら消す
        mypage_customers_path
      else
        items_path # ログイン後も新着商品一覧へ
      end
    else
      root_path
    end
  end

  # ログアウト後の遷移先
  def after_sign_out_path_for(resource_or_scope)
    case resource_or_scope
    when :admin
      new_admin_session_path # 管理者ログイン画面へ
    when :customer
      root_path # ← トップページに変更！    
    else
      root_path
    end
  end
end

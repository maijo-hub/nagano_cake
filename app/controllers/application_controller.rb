class ApplicationController < ActionController::Base
  # ログイン後の遷移先
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_root_path
    when Customer
      if session[:previous_action] == "sign_up"
        session[:previous_action] = nil # 一度使ったら消す
        customers_mypage_path
      else
        items_path
      end
    else
      root_path
    end
  end

  # ログアウト後の遷移先
  def after_sign_out_path_for(resource_or_scope)
    case resource_or_scope
    when :admin
      new_admin_session_path
    when :customer
      items_path
    else
      root_path
    end
  end
end

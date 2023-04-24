class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top,:about]
  before_action :configure_permitted_parameters, if: :devise_controller?


    def after_sign_in_path_for(resource) #サインイン後ユーザビューに遷移
      flash[:notice] = "successfully sign in"
      user_path(current_user.id)
    end
    def after_sign_up_path_for(resource) #サインイン後ユーザビューに遷移
      flash[:notice] = "successfully sign up"
      user_path(current_user.id)
    end

    # def after_sign_out_path_for(resource) #サインアウト後はデフォルト

    # end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys: [:email])
    end

end

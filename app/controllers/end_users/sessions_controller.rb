# frozen_string_literal: true

class EndUsers::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # def after_sign_in_path_for(resource)
  #   root_path
  # end

  # def after_sign_out_for(resource)
  #   root_path
  # end

  def reject_user
    @end_user = EndUser.find_by(name: params[:name].downcase)
    if @end_user
      if (@end_user.valid_password?(params[:name][:password]) && (@end_user.active_for_authentication? == false))
        flash[:error] = "ユーザーの登録情報がありません。"
        redirect_to new_user_session_path
      end
  end

end

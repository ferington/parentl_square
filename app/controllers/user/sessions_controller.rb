# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_customer, only: [:create]
  
  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to posts_path, notice: "guestuserでログインしました"
  end
  
  private
  
  #新規投稿場所がわかれば変更する
  def reject_customer
    customer = Customer.find_by(email: params[:customer][:email])

    if customer.nil?
      flash[:notice] = "該当するユーザーが見つかりません"
    elsif customer&.is_deleted
      redirect_to new_customer_session_path, alert: "退会済みのアカウントです。再度ご登録してご利用ください"
    else
      flash[:notice] = "項目を入力してください"
    end
  end

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
end

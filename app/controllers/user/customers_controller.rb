class User::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def index
    @customers = Customer.where(is_deleted: false)
    @customer = current_customer
    @post = Post.new
    @pusts = Post.all
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "プロフィールの編集しました"
      redirect_to customer_path(@customer.id)
    else
      render :edit
    end
  end

  def withdraw
    @customer = Customer.find(current_customer.id)

    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image, :introduction)
  end

  def ensure_guest_user
    @customer = Customer.find(params[:id])
    if @customer.guest_user?
      redirect_to customer_path(current_customer) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません"
    end
  end

  def correct_user
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to customer_path(current_customer), notice: "他のユーザーのプロフィール編集はできません"
    end
  end
end
class User::CustomersController < ApplicationController
  def index
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

  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image, :introduction)
  end
  
end

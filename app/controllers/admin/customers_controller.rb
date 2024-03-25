class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.where(is_deleted: false)
  end
  
  def destroy
    @customer = Customer.find_by(id: params[:id])  
    if @customer
      @customer.destroy
      redirect_to admin_customers_path, notice: '登録ユーザーを削除されました。'
    else
      redirect_to admin_customers_path, alert: 'ユーザーが見つかりませんでした。'
    end
  end
end
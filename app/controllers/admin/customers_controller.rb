class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.where(is_deleted: false)
  end

  def destroy
    @customer = Customer.find_by(id: params[:id])
    if @customer
      @customer.destroy
      redirect_to admin_customers_path, notice: 'ユーザー情報が正常に停止されました'
    else
      redirect_to admin_customers_path, alert: 'ユーザー情報が見つかりませんでした'
    end
  end
end
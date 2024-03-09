class User::CustomersController < ApplicationController
  def index
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
  end

  def edit
  end
end

class Admin::PostCommentsController < ApplicationController
  def index
    @post_comments = PostComment.joins(:customer).where(customers: {is_deleted: false})
    @customers = Customer.where(is_deleted: false)
  end

  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    redirect_to admin_post_comments_path
  end
end

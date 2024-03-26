class Admin::PostCommentsController < ApplicationController
  def index
    @post_comments = PostComment.joins(:customer).where(customers: {is_deleted: false})
    @customers = Customer.where(is_deleted: false)
  end

  def destroy
    @post_comment = PostComment.find(params[:id])
    if @post_comment
      @post_comment.destroy
      redirect_to admin_post_comments_path, notice: 'コメントを正常に削除されました。'
    else
      redirect_to admin_post_comments_path, alert: 'コメントが見つかりませんでした。'
    end
  end
end

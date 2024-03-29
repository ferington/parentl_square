class Admin::PostsController < ApplicationController
  def index
    @user_posts = Post.all
    @customers = Customer.where(is_deleted: false)
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])  
    if @post
      @post.destroy
      redirect_to admin_posts_path, notice: '投稿レビューを正常に削除されました'
    else
      redirect_to admin_posts_path, alert: '投稿レビューが見つかりませんでした'
    end
  end
end
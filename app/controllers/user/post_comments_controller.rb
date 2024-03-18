class User::PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment = current_customer.post_comments.new(post_comment_params)
    comment.post_id = @post.id
    comment.save
    #redirect_to request.referer
  end

  def destroy
    comment = PostComment.find(params[:id])
    
    @user_post = comment.post
    
    comment.destroy
    #redirect_to Post.find(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end

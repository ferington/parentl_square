class User::PostsController < ApplicationController
  before_action :set_user_post, only: %i[ show edit update destroy ]
  before_action :check_user, only: [:edit]

  # GET /user/posts or /user/posts.json
  def index
  #  @user_posts = current_customer.posts
    @posts = Post.all
  #  @user_posts = Post.all
  # <!--ソート機能のコード-->
    if params[:latest]
      @user_posts = Post.latest.page(params[:page]).per(8)
    elsif params[:old]
      @user_posts = Post.old.page(params[:page]).per(8)
    elsif params[:star_count]
      @user_posts = Post.star_count.page(params[:page]).per(8)
    else
      @user_posts = Post.page(params[:page]).per(8)
    end
  end

  # GET /user/posts/1 or /user/posts/1.json
  def show
  # <!--タグ投稿のコード-->
    @user_post = Post.find(params[:id])
    @tag_list = @user_post.tags.pluck(:name).join('、')
    @user_post_tags = @user_post.tags
  # <!--コメント投稿-->
    @post_comment = PostComment.new
  # <!--投稿文code-->
    @user_post = Post.find(params[:id])
  # <!--投稿者以外がURLから入ろうとしたときのエラー文-->
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "指定されたポストが見つかりません。"
  end

  # GET /user/posts/new
  def new
    @user_post = Post.new
  #  @tag_list = @user_post.tags.pluck(:name).join(',')
  end

  # GET /user/posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  # POST /user/posts or /user/posts.json
  def create
    @user_post = current_customer.posts.new(user_post_params)
    # 受け取った値を,で区切って配列にする
    tag_list = params[:post][:name].present? ? params[:post][:name].split('、') : []

    respond_to do |format|
      if @user_post.save
        @user_post.save_tags(tag_list)
        format.html { redirect_to post_url(@user_post), notice: "投稿が完了しました" }
        format.json { render :show, status: :created, location: @user_post }
      else
        # バリデーションエラーなど、保存が失敗した場合の処理
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user/posts/1 or /user/posts/1.json
  def update
    respond_to do |format|
      if @user_post.update(user_post_params)
        format.html { redirect_to post_url(@user_post), notice: "投稿は正常に更新されました" }
        format.json { render :show, status: :ok, location: @user_post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user/posts/1 or /user/posts/1.json
  def destroy
    @user_post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "投稿を削除しました" }
      format.json { head :no_content }
    end
  end

  def search_tag
    @tag = Tag.find(params[:tag_id])
    @tag_list = Tag.all
    @posts = @tag.posts
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_post
      @user_post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_post_params
      params.require(:post).permit(:title, :content, :star)
    end

    def check_user
      unless @user_post.customer_id == current_customer.id
        redirect_to posts_path, alert: 'アクセス権限がありません。'
      end
    end
end

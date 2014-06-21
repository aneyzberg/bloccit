
class PostsController < ApplicationController
  before_action :find_topic

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    authorize @post
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.topic = @topic

    authorize @post
    if @post.save
      redirect_to [@topic, @post], notice: "Post was saved successfully."
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def update    
    @post = Post.find(params[:id])
    authorize @post
    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def find_topic
    @topic = Topic.find(params[:topic_id])
  end
end
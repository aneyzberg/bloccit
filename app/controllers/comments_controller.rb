class CommentsController < ApplicationController

    def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments


    # @comment = @Comment.new(comment_params)
    # @comment.user = current_user
    # @comment.post = @post

    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
    @new_comment = Comment.new

    authorize @comment

    if @comment.save
      redirect_to [@topic, @post], notice: "Comment was saved successfully"
     # flash[:notice] = "Comment was saved successfully."
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new

    # respond_with(@comment) do |f|
      # f.html { redirect_to [@topic, @post] }
    end
  end

    def comment_params
    params.require(:comment).permit(:body, :post_id)
  end

end

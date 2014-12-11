class CommentsController < ApplicationController
  
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    render :new
  end
  
  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      flash[:notices] = ["Comment was created"]
      if @comment.parent_comment.nil?
        redirect_to post_url(@comment.post)
      else
        redirect_to post_comment_url(@comment.post, @comment.parent_comment)
      end
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to post_comment_url(@comment.post, @comment)
    end
  end
  
  def show
    @comment = Comment.find(params[:id])
    render :show
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end

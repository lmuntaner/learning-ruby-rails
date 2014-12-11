class PostsController < ApplicationController
  
  before_action :set_post, except: [:new, :create]
  
  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end
  
  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      flash[:notices] = ["Post has been saved"]
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end
  
  def show
    render :show
  end
  
  def edit
    @subs = Sub.all
    render :edit
  end
  
  def update    
    if @post.update(post_params)
      flash[:notices] = ["Updated successfully"]
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    @sub = @post.topic
    @post.destroy
    redirect_to sub_url(@sub)
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :url, :content, topic_ids: [])
  end
  
  def set_post
    @post = Post.find(params[:id])
  end
end

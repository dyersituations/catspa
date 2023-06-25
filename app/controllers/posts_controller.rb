class PostsController < ApplicationController
  before_action :load_post, :only => [:show, :update, :destroy, :sold]

  def new
    @post = Post.new
    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        page = Page.find(@post.page_id)
        format.html { redirect_to root_path + URI.encode(page.path), notice: "Post was successfully created." }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @page_path = Page.find(@post.page_id).path
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to request.referer, notice: "Successfully updated." }
      else
        format.html { redirect_to request.referer, notice: "Updated not successful." }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @post.destroy
        format.html { redirect_to request.referer, notice: "Successfully removed." }
      else
        format.html { redirect_to request.referer, notice: "Remove not successful." }
      end
    end
  end

  def sold
    quantity = @post.quantity - 1
    @post.update(:quantity => quantity)    
  end

  private

  def post_params
    params.require(:post).permit(:content, :image, :title, :category, :page_id, :price, :quantity)
  end

  def load_post
    @post = Post.find(params[:id])
  end
end

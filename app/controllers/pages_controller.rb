class PagesController < ApplicationController
  before_action :authorize, :except => :show
  before_action :load_page, :except => :cancel
  before_action :plain, :only => [:new, :edit]
  after_action -> { flash.discard }

  def show
    case @page.page_type
    when Page::PAGE_TYPE[:BLOG]
      load_posts_desc
      @view = "layouts/blog"
    when Page::PAGE_TYPE[:GALLERY]
      load_posts_alpha
      @view = "layouts/gallery"
    else
      @view = "layouts/plain"
    end
  end

  def new
    @page = Page.new
  end

  def create
    save_page
  end

  def update
    save_page
  end

  def cancel
    clear_old_images
    path = params[:path]
    respond_to do |format|
      format.html { redirect_to path ? root_url + path : root_url }
    end
  end

  def destroy
    Page.find_by_id(params[:id]).destroy
    clear_old_images
    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end

  def edit_posts
    @posts = Post.where("posts.page_id=?", @page.id).order("title ASC")
  end

  private

  def page_params
    page = params[:page]
    if !page.nil?
      page.permit(:path, :page_type, :page_sub_type, :page_order, :remove_banner, :banner, :content, :title, :banner_cache)
    end
  end

  def plain
    @plain = @page == nil || @page.page_type == Page::PAGE_TYPE[:PLAIN]
  end

  def load_page
    if params[:id]
      # Id means the page is edited.
      @page = Page.find_by_id(params[:id])
    elsif params[:path]
      # Path means the page is shown.
      @path = params[:path].downcase
      @page = Page.where("lower(pages.path)=?", @path).first
    elsif !page_params.nil?
      # Page not nil when failing to save new page.
      @page = Page.new(page_params)
    elsif !Page.any? && action_name != "new"
      redirect_to admin_path
    else
      # When loading root.
      @page = Page.first
      @path = @page.nil? ? "" : @page.path.downcase
    end
  end

  def load_posts_alpha
    @posts = Post.where("posts.page_id=?", @page.id)
    @cats = @posts.order("category ASC").pluck(:category)
    if @posts.count > 0
      @cat = params[:category]
      if @cat == nil
        @cat = @cats.uniq.sort.first
      end
      @cat = @cat.downcase
      @posts = @posts.where("lower(posts.category)=?", @cat).order("title ASC")
    else
      @posts = []
    end
  end

  def load_posts_desc
    @posts = Post.where("posts.page_id=?", @page.id).order("created_at DESC")
  end

  def save_page
    updated_params = page_params
    begin
      updated_params.require(:path)
    rescue ActionController::ParameterMissing
      flash[:notice] = "Path required."
      render :edit
      return
    end
    # TinyMCE overwrites image URLs.
    updated_params[:content] = updated_params[:content]
      .gsub(/src=".*\/uploads/, "src=\"/uploads")
    if params[:id]
      @page = Page.find_by_id(params[:id])
    else
      @page = Page.new(updated_params)
    end
    # Page content not needed for GALLERY or BLOG.
    if @page.page_type == Page::PAGE_TYPE[:GALLERY] || @page.page_type == Page::PAGE_TYPE[:BLOG]
      @page.content = ""
    end
    begin
      if params[:id]
        success = @page.update(updated_params)
      else
        success = @page.save
      end
    rescue ActiveRecord::RecordNotUnique => e
      flash[:notice] = "Unique path required. Choose banner again if needed."
      render :new
      return
    end
    if success
      clear_old_images
      respond_to do |format|
        format.html { redirect_to page_view_path(@page.path) }
      end
    else
      flash[:notice] = "Error saving page. Choose banner again if needed."
      render :new
    end
  end

  def clear_old_images
    pages = Page.all
    EditorImage.all.each do |editor_image|
      found = false
      pages.each do |page|
        images = page.content
          .scan(/editor_image\/file\/[\d]+\/[\w]+.(?:jpg|jpeg|gif|png)/i)
        images.each do |image|
          id = image.scan(/\/file\/([\d]+)\/[\w]+/i).first.first
          if id.to_i == editor_image.id
            found = true
            break
          end
        end
      end
      if !found
        editor_image.destroy
      end
    end
  end
end

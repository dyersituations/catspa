class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :pages_with_posts, :new_action
  before_action :load_pages

  def authorize
    if !Settings.instance.is_admin_pass && params[:controller] != 'admin'
      redirect_to admin_path
    elsif !session[:admin] && Settings.instance.is_admin_pass && !Settings.instance.is_admin_pass.empty? && params[:action] != 'login'
      session[:login_redirect] = request.original_url
      redirect_to login_path
    end
  end  

  private

  def load_pages
    @pages = Page.all.order("page_order ASC")
  end

  def pages_with_posts
    Page.where('pages.page_type IN (?, ?)', Page::PAGE_TYPE[:BLOG], Page::PAGE_TYPE[:GALLERY])
  end

  def new_action
    params[:action] == 'new'
  end
end

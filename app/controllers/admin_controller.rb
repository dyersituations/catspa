class AdminController < ApplicationController
  before_action :authorize, :except => [:login, :login_admin]
  before_action :load_pages, :only => [:login, :admin]

  def admin
    @settings = Settings.instance.get_settings
  end

  def save
    admin_pass = params[:admin_pass]
    confirm_admin_pass = params[:confirm_admin_pass]
    if admin_pass != Settings::ADMIN_PASS && admin_pass != confirm_admin_pass
      flash[:notice] = "Confirmation password doesn't match!"
    else
      begin
        if !params[:favicon].blank?
          save_favicon
        end
        Settings.instance.save(params)
      rescue ActionController::ParameterMissing
        flash[:notice] = "Error uploading favicon. Try again!"
      end
    end
    redirect_to admin_path
  end

  def login
    if !Settings.instance.is_admin_pass
      redirect_to admin_path
    end
  end

  def login_admin
    if (Settings.instance.admin_authenticate?(params[:admin_pass]))
      session[:admin] = true
      login_redirect = session[:login_redirect]
      session.delete(:login_redirect)
      redirect_to login_redirect ? login_redirect : root_path
    else
      flash[:notice] = "Admin password incorrect!"
      redirect_to admin_path
    end
  end

  def logout
    reset_session
    redirect_to root_path
  end

  private

  def save_favicon
    if Settings.instance.favicon != "" && Settings.instance.favicon != Settings::FAVICON
      File.delete(Rails.root.join("public", Settings.instance.favicon))
    end
    new_favicon = "favicon_#{Time.now.to_i}.ico"
    File.open(Rails.root.join("public", new_favicon), "wb") do |file|
      file.write(params[:favicon].read)
    end
    params[:favicon] = new_favicon
  end
end

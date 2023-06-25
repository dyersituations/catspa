Rails.application.routes.draw do
  # Page display routes.
  root :to => "pages#show"
  # Admin routes.
  get "login" => "admin#login"
  post "login_admin" => "admin#login_admin"
  get "admin" => "admin#admin"
  post "admin/save" => "admin#save"
  get "logout" => "admin#logout"
  # Post routes.
  resources :posts, only: [:new, :create, :show, :update, :destroy]
  # Page routes.
  resources :pages, only: [:new, :create, :show, :edit, :update, :destroy]
  post "pages/new" => "pages#create"
  get "page_edit_cancel(/:path)" => "pages#cancel"
  # Post display and edit routes.
  get "edit_posts" => "pages#edit_posts"
  get ":path" => "pages#show", :as => "page_view"
  get "gallery/:category" => "pages#show", :defaults => { :path => "gallery" }
  # Post editor image.
  post "tinymce_assets" => "tinymce_assets#create"
  post "posts/:id/sold" => "posts#sold"
end

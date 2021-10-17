Rails.application.routes.draw do
  resources :user_advertises
  resources :user_marketings
  namespace 'api' do
    resources :advertisements, :auth, :comment
    scope '/advertisements' do
      patch "publish/:id" => "advertisements#publish"
      post "create_adds/:id" => "advertisements#create_adds"
      get "get_user_adds/:id" => "advertisements#get_user_adds"
    end
    scope '/auth' do
      post "login" => "auth#login"
      post "register" => "auth#register"
      post "logout" => "auth#logout"
    end
    scope '/comment' do
      post "post_comment/:id" => "comment#post_comment"
      delete "delete/:id" => "comment#delete"
      post "get_comments/:id" => "comment#get_comments"
      patch "update_comment/:id" => "comment#update_comment"
      get "get_user_comments/:id" => "comment#get_user_comments"
    end
  end
end
Rails.application.routes.draw do
  namespace 'api' do
    resources :advertisements, :auth
    scope '/auth' do
      post "login" => "auth#login"
      post "register" => "auth#register"
      post "logout" => "auth#logout"
    end
  end
end
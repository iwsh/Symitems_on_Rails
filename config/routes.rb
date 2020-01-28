Rails.application.routes.draw do
  get 'stab/calender'
  get 'stab/index'
  get 'login' => 'authentications#login'
  get 'logout' => 'authentications#logout'
  post 'auth' => 'authentications#checkUser'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

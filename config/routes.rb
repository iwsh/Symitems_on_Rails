Rails.application.routes.draw do
  get 'login' => 'authentications#login'
  get 'logout' => 'authentications#logout'
  get 'auth' => 'authentications#login'
  post 'auth' => 'authentications#checkUser'

  get 'calendar' => 'calendars#calendar'
  get 'calendar/:year/:month' => 'calendars#calendar'
  post 'calendars/registerSchedule'
  post 'access_schedules/deleteSchedule'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
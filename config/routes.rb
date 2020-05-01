Rails.application.routes.draw do
  get 'login' => 'authentications#login'
  get 'logout' => 'authentications#logout'
  get 'auth' => 'authentications#login'
  post 'auth' => 'authentications#checkUser'

  get 'calendar' => 'calendars#calendar'
  get 'calendar/:year/:month' => 'calendars#calendar'
  # get 'add/:date' => 'calendars#inputSchedule'
  # get 'edit/:schedule_id' => 'calendars#inputSchedule'
  post 'calendars/registerSchedule'
  # get 'deleteConfirm/:schedule_id' => 'calendars#deleteConfirm'
  post 'access_schedules/deleteSchedule'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
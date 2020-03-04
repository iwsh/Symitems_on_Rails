Rails.application.routes.draw do
  get 'acsess_schedules/getSchedule'
  get 'acsess_schedules/updateSchedule'
  get 'acsess_schedules/insertSchedule'
  get 'acsess_schedules/deleteSchedule'
  get 'stab_authentications/login'
  get 'stab_authentications/checkUser'
  get 'stab_authentications/logout'
  get 'calendar' => 'calendars#calendar'
  get 'calendars/inputSchedule'
  get 'calendars/registerSchedule'
  get 'calendars/deleteConfirm'
  get 'calendar/:year/:month' => 'calendars#calendar'
  get 'logout' => 'authentications#logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

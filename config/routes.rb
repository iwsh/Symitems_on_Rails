Rails.application.routes.draw do
  get 'acsess_schedules/getSchedule'
  get 'acsess_schedules/updateSchedule'
  get 'acsess_schedules/insertSchedule'
  get 'acsess_schedules/deleteSchedule'
  # get "acsessdbs/getSchedule/:date" => "calenders#calender"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

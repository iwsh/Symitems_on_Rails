Rails.application.routes.draw do
  get 'acsessdbs/getSchedule'
  get 'acsessdbs/updateSchedule'
  get 'acsessdbs/insertSchedule'
  get 'acsessdbs/deleteSchedule'
  # get "acsessdbs/getSchedule/:date" => "calenders#calender"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
# <<<<<<< HEAD

# # 既存スケジュールの表示
# #  get 'schedule/:schedule_id' => 'access_schedules#getSchedule'

# # 既存スケジュールの変更、calendars#inputScheduleに含められない場合、作成予定
#   get 'schedule/:schedule_content_id' => 'calendars#edit'
#   put 'schedule/:schedule_content_id' => 'calendars#update'

# # スケジュールの新規登録
#   get 'schedule' => 'calendars#inputSchedule'
#   post 'schedule' => 'calendars#registerSchedule'

# # スケジュールの削除
#   get 'schedule/:schedule_content_id/delete' => 'calendars#deleteConfirm'
#   #delete 'schedule/:schedule_content_id/delete' => 'calendars#deleteConfirm'

# =======
  get 'login' => 'authentications#login'
  get 'logout' => 'authentications#logout'
  get 'auth' => 'authentications#login'
  post 'auth' => 'authentications#checkUser'
  get 'access_schedules/getSchedule'
  get 'access_schedules/updateSchedule'
  get 'access_schedules/insertSchedule'
  post 'access_schedules/deleteSchedule'
  # get 'stab_authentications/login'
  # get 'stab_authentications/checkUser'
  # get 'stab_authentications/logout'
# >>>>>>> develop
  get 'calendar' => 'calendars#calendar'
  post 'calendars/registerSchedule'
  get 'add/:date' => 'calendars#inputSchedule'
  get 'edit/:schedule_id' => 'calendars#inputSchedule'
  get 'deleteConfirm/:schedule_id' => 'calendars#deleteConfirm'
  get 'calendar/:year/:month' => 'calendars#calendar'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
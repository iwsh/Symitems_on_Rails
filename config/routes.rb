Rails.application.routes.draw do

# 既存スケジュールの表示
#  get 'schedule/:schedule_id' => 'access_schedules#getSchedule'

# 既存スケジュールの変更、calendars#inputScheduleに含められない場合、作成予定
  get 'schedule/:schedule_content_id' => 'calendars#edit'
  put 'schedule/:schedule_content_id' => 'calendars#update'

# スケジュールの新規登録
  get 'schedule' => 'calendars#inputSchedule'
  post 'schedule' => 'calendars#registerSchedule'

# スケジュールの削除
  get 'schedule/:schedule_content_id/delete' => 'calendars#deleteConfirm'
  #delete 'schedule/:schedule_content_id/delete' => 'calendars#deleteConfirm'

  get 'stab_authentications/login'
  get 'stab_authentications/checkUser'
  get 'stab_authentications/logout'
  get 'calendar' => 'calendars#calendar'
#  get 'calendars/inputSchedule'
  get 'calendars/registerSchedule'
  get 'calendars/deleteConfirm'
  get 'calendar/:year/:month' => 'calendars#calendar'
  get 'logout' => 'authentications#logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
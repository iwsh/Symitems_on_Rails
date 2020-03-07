Rails.application.routes.draw do

# 既存スケジュールの表示
#  get 'schedule/:schedule_id' => 'access_schedules#getSchedule'

# 既存スケジュールの変更、calendars#inputScheduleに含められない場合、作成予定
  get 'schedule/:schedule_id' => 'calendars#edit'
  put 'schedule/:schedule_id' => 'calendars#update'

# スケジュールの新規登録
  get 'schedule' => 'calendars#inputSchedule'
  post 'schedules' => 'calendars#registerSchedule'

  get 'access_schedules/deleteSchedule'
  get 'calendar' => 'calendars#calendar'
#  get 'calendars/inputSchedule'
  get 'calendars/registerSchedule'
  get 'calendars/deleteConfirm'
  get 'calendar/:year/:month' => 'calendars#calendar'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
class AcsessdbsController < ApplicationController
  def getSchedule
    @displayYear = 2020 #TODO:しげから受け取る表示年、数値型で渡される想定
    @displayMonth = 2 #TODO:しげから受け取る表示月、数値型で渡される想定

    @lastDay = Date.new(@displayYear, @displayMonth, -1).strftime
    @dateFrom = format("#{@displayYear}-%02d-01", @displayMonth)
    @dateTo = format("#{@displayYear}-%02d-#{@lastDay}", @displayMonth)

    Schedule.joins(:schedule_content)
    @schedules = Hash.new
    @schedules = Schedule.where("date BETWEEN ? AND ?", @dateFrom, @dateTo)
  end

  def updateSchedule
    @updateScheduleContent = Hash.new #TODO:ごっちゃんから受け取る
    @updateScheduleContent[:id] = 5
    @updateScheduleContent[:title] = 'スノーボード'
    @updateScheduleContent[:started_at] = '2020-02-11 12:00:00'
    @updateScheduleContent[:ended_at] = '2020-02-11 14:00:00'
    @updateScheduleContent[:detail] = '滑る'

    @updateSchedule = Hash.new #TODO:ごっちゃんから受け取る
    @updateSchedule[:id] = 5

    @scheduleContent = Hash.new
    @scheduleContent = ScheduleContent.find_by(id: @updateScheduleContent[:id])
    @scheduleContent.update(
      title: @updateScheduleContent[:title],
      started_at: @updateScheduleContent[:started_at],
      ended_at: @updateScheduleContent[:ended_at],
      detail: @updateScheduleContent[:detail],
      updated_at: DateTime.now
    )

    @schedule = Hash.new
    @schedule = Schedule.find_by(id: @updateSchedule[:id])
    @schedule.update(
      content_id: @updateScheduleContent[:id],
      schedule_content_id: @updateScheduleContent[:id],
      updated_at: DateTime.now
    )
  end

  def insertSchedule
    @insertScheduleContent = Hash.new #TODO:ごっちゃんから受け取る
    @insertScheduleContent[:id] = 8
    @insertScheduleContent[:title] = '旅行'
    @insertScheduleContent[:started_at] = '2020-02-15 12:00:00'
    @insertScheduleContent[:ended_at] = '2020-02-15 14:00:00'
    @insertScheduleContent[:detail] = 'ウェイ'

    @insertSchedule = Hash.new #TODO:ごっちゃんから受け取る
    @insertSchedule[:date] = '2020-02-15'
    @insertSchedule[:id] = 7
    @insertSchedule[:user_id] = 2

    @scheduleContent = ScheduleContent.create(
      title: @insertScheduleContent[:title],
      started_at: @insertScheduleContent[:started_at],
      ended_at: @insertScheduleContent[:ended_at],
      detail: @insertScheduleContent[:detail],
      created_at: DateTime.now,
      updated_at: DateTime.now
    )
    @scheduleContent.save

    @schedule = Schedule.create(
      date: @insertSchedule[:date],
      user_id: @insertSchedule[:user_id],
      content_id: @insertScheduleContent[:id],
      schedule_content_id: @insertScheduleContent[:id],
      created_at: DateTime.now,
      updated_at: DateTime.now
    )
    @schedule.save
  end

  def deleteSchedule
    @deleteScheduleContentId = '8' #TODO:ごっちゃんから受け取る
    @deleteScheduleId = '7' #TODO:ごっちゃんから受け取る

    @schedule = Schedule.find_by(id: @deleteScheduleId)
    @schedule.delete

    @scheduleContent = ScheduleContent.find_by(id: @deleteScheduleContentId)
    @scheduleContent.delete
  end
end

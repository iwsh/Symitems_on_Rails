class AccessSchedulesController < ApplicationController
  def getSchedule(userId,displayYear,displayMonth)
    lastDay = Date.new(displayYear, displayMonth, -1).strftime
    dateFrom = format("#{displayYear}-%02d-01", displayMonth)
    dateTo = format("#{displayYear}-%02d-#{lastDay}", displayMonth)

    Schedule.joins(:schedule_content)
    schedules = Hash.new
    schedules = Schedule.where("date BETWEEN ? AND ?", dateFrom, dateTo).where(user_id: userId)

    displaySchedules = {}
    schedules.each{|schedule|
      day = schedule.date.mday
      displaySchedules[day] = schedule
    }
    return displaySchedules
  end

  # def updateSchedule(updateSchedule) #TODO:本番用コード
  def updateSchedule #TODO:ごっちゃんから受け取れるようになるまでの暫定対応
    @updateScheduleContent = Hash.new #TODO:ごっちゃんから受け取れるようになるまでの暫定対応
    @updateScheduleContent[:id] = 5
    @updateScheduleContent[:title] = 'スノーボード'
    @updateScheduleContent[:started_at] = '2020-02-11 12:00:00'
    @updateScheduleContent[:ended_at] = '2020-02-11 14:00:00'
    @updateScheduleContent[:detail] = '滑る'

    @updateSchedule = Hash.new #TODO:ごっちゃんから受け取れるようになるまでの暫定対応
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

  def insertSchedule(insertSchedule)
    userId = 2 #session対応完了までの暫定対応
    # userId = session[:user] #TODO:本番用コード

    # transaction張りたい
    @scheduleContent = ScheduleContent.create(
      title: insertSchedule[:title],
      started_at: insertSchedule[:started_at],
      ended_at: insertSchedule[:ended_at],
      detail: insertSchedule[:detail],
      created_at: DateTime.now,
      updated_at: DateTime.now
    )
    @scheduleContent.save

    incertedScheduleContent = ScheduleContent.last

    @schedule = Schedule.create(
      date: insertSchedule[:date], #ごっちゃんから受け取らない場合は、本メソッドでinsertSchedule[:started_at]から取得
      user_id: userId,
      content_id: incertedScheduleContent.id,
      schedule_content_id: incertedScheduleContent.id,
      created_at: DateTime.now,
      updated_at: DateTime.now
    )
    @schedule.save
  end

  def deleteSchedule(selectedDeleteScheduleId, isDeleteAll = 1)
    userId = '2' #TODO:session対応完了までの暫定対応
    # userId = session[:user] #TODO:本番用コード

    Schedule.joins(:schedule_content)
    selectedDeleteSchedule = Hash.new
    selectedDeleteSchedule = Schedule.where(id: selectedDeleteScheduleId).where(user_id: userId)
    deleteScheduleContentId = selectedDeleteSchedule.schedule_content.id

    if isDeleteAll == 1
      Schedule.joins(:schedule_content)
      @schedule = Schedule.where(schedule_content.id: deleteScheduleContentId)
      @schedule.delete_all
    else
      @schedule = Schedule.find_by(id: deleteScheduleId)
      @schedule.delete
    end

    @scheduleContent = ScheduleContent.find_by(id: deleteScheduleContentId)
    @scheduleContent.delete
  end
end

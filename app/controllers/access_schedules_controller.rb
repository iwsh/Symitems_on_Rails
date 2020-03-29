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

  # def updateSchedule(updateScheduleContent,updateSchedule) #TODO:本番用コード
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

  # def insertSchedule(insertScheduleContent,insertSchedule) #TODO:本番用コード
  def insertSchedule #TODO:ごっちゃんから受け取れるようになるまでの暫定対応
    @insertScheduleContent = Hash.new #TODO:ごっちゃんから受け取れるようになるまでの暫定対応
    @insertScheduleContent[:id] = 8
    @insertScheduleContent[:title] = '旅行'
    @insertScheduleContent[:started_at] = '2020-02-15 12:00:00'
    @insertScheduleContent[:ended_at] = '2020-02-15 14:00:00'
    @insertScheduleContent[:detail] = 'ウェイ'

    @insertSchedule = Hash.new #TODO:ごっちゃんから受け取れるようになるまでの暫定対応
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

  # def deleteSchedule(deleteScheduleContentId,deleteScheduleId) #TODO:本番用コード
  def deleteSchedule #TODO:ごっちゃんから受け取れるようになるまでの暫定対応
    @deleteScheduleContentId = '8' #TODO:ごっちゃんから受け取れるようになるまでの暫定対応
    @deleteScheduleId = '7' #TODO:ごっちゃんから受け取れるようになるまでの暫定対応

    @schedule = Schedule.find_by(id: @deleteScheduleId)
    @schedule.delete

    @scheduleContent = ScheduleContent.find_by(id: @deleteScheduleContentId)
    @scheduleContent.delete
  end
end

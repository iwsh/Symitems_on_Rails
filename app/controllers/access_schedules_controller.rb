class AccessSchedulesController < ApplicationController
  def getSchedule(userId, displayYear, displayMonth)
    lastDay = Date.new(displayYear, displayMonth, -1).day
    dateFrom = format("#{displayYear}-%02d-01", displayMonth)
    dateTo = format("#{displayYear}-%02d-#{lastDay}", displayMonth)

    Schedule.joins(:schedule_content)
    schedules = Hash.new
    schedules = Schedule.where(date: dateFrom..dateTo, user_id: userId)

    displaySchedules = {}
    schedules.each{|schedule|
      day = schedule.date.mday
      if displaySchedules[day].nil?
        displaySchedules[day] = []
      end
      displaySchedules[day].push(schedule)
    }
      return displaySchedules
  end

  def updateSchedule(schedules)
    scheduleForId = Hash.new
    scheduleForId = Schedule.where(id: schedules[:id].to_i, user_id: schedules[:user_id])
    scheduleContentId = scheduleForId[0].content_id

    # transaction張りたい
    @scheduleContent = Hash.new
    @scheduleContent = ScheduleContent.find_by(id: scheduleContentId)
    @scheduleContent.update(
      title: schedules[:title],
      started_at: schedules[:started_at],
      ended_at: schedules[:ended_at],
      detail: schedules[:detail],
      updated_at: DateTime.now
    )

    @schedule = Hash.new
    @schedule = Schedule.find_by(id: schedules[:id])
    @schedule.update(
      date: schedules[:date],
      content_id: scheduleContentId,
      updated_at: DateTime.now
    )
  end

  def insertSchedule(schedules)
    ActiveRecord::Base.transaction do # transaction張りたい
    @scheduleContent = ScheduleContent.create(
      title: schedules[:title],
      started_at: schedules[:started_at],
      ended_at: schedules[:ended_at],
      detail: schedules[:detail],
      created_at: DateTime.now,
      updated_at: DateTime.now
    ).valid?
    if @scheduleContent == false
      raise ActiveRecord::Rollback
    end
    # @scheduleContent.save

    insertedScheduleContentId = ScheduleContent.last.id

    @schedule = Schedule.create(
      date: schedules[:date],
      user_id: schedules[:user_id],
      content_id: insertedScheduleContentId,
      created_at: DateTime.now,
      updated_at: DateTime.now
    ).valid?
    if @schedule == false
      raise ActiveRecord::Rollback
    end
    # @schedule.save

    rescue => e
      # flash.now[:danger] = '開始/終了時刻を入力してください'
      p "false"
    end
  end

  def deleteSchedule(ids)
    selectedDeleteScheduleId = ids[:id]
    isDeleteAll = 1
    userId = ids[:user_id]

    selectedDeleteSchedule = Hash.new
    selectedDeleteSchedule = Schedule.where(id: selectedDeleteScheduleId, user_id: userId)
    selectedDeleteScheduleContentId = selectedDeleteSchedule[0].content_id

    if isDeleteAll == 1
      @schedule = Schedule.where(content_id: selectedDeleteScheduleContentId)
      @schedule.delete_all
    else
      @schedule = Schedule.find_by(id: selectedDeleteScheduleId)
      @schedule.delete
    end

    @scheduleContent = ScheduleContent.find_by(id: selectedDeleteScheduleContentId)
    @scheduleContent.delete
  end
end
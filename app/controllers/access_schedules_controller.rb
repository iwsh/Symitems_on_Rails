class AccessSchedulesController < ApplicationController
  def getSchedule(userId, displayYear, displayMonth)
    lastDay = Date.new(displayYear, displayMonth, -1).day
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

  def updateSchedule(updateSchedule)
    scheduleForId = Hash.new
    scheduleForId = Schedule.where(id: updateSchedule[:id].to_i).where(user_id: updateSchedule[:user_id])
    scheduleContentId = scheduleForId[0].content_id

    # transaction張りたい
    @scheduleContent = Hash.new
    @scheduleContent = ScheduleContent.find_by(id: scheduleContentId)
    @scheduleContent.update(
      title: updateSchedule[:title],
      started_at: updateSchedule[:started_at],
      ended_at: updateSchedule[:ended_at],
      detail: updateSchedule[:detail],
      updated_at: DateTime.now
    )

    @schedule = Hash.new
    @schedule = Schedule.find_by(id: updateSchedule[:id])
    @schedule.update(
      date: updateSchedule[:date],
      content_id: scheduleContentId,
      updated_at: DateTime.now
    )
  end

  def insertSchedule(insertSchedule)

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

    insertedScheduleContent = ScheduleContent.last

    @schedule = Schedule.create(
      date: insertSchedule[:date],
      user_id: insertSchedule[:user_id],
      content_id: insertedScheduleContent.id,
      created_at: DateTime.now,
      updated_at: DateTime.now
    )
    @schedule.save
  end

  def deleteSchedule
    selectedDeleteScheduleId = params[:schedule_id]
    isDeleteAll = 1
    userId = session[:user]["id"]

    selectedDeleteSchedule = Hash.new
    selectedDeleteSchedule = Schedule.where(id: selectedDeleteScheduleId).where(user_id: userId)
    deleteScheduleContentId = selectedDeleteSchedule[0].content_id

    if isDeleteAll == 1
      @schedule = Schedule.where(content_id: deleteScheduleContentId)
      @schedule.delete_all
    else
      @schedule = Schedule.find_by(id: deleteScheduleId)
      @schedule.delete
    end

    @scheduleContent = ScheduleContent.find_by(id: deleteScheduleContentId)
    @scheduleContent.delete
  end
end

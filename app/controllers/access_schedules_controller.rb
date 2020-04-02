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

  def updateSchedule(userId, updateSchedule)
    Schedule.joins(:schedule_content) #TODO:deleteScheduleでも使っているので、getScheduleContentIdメソッドを作りたい。
    updateSchedule = Hash.new
    updateSchedule = Schedule.where(id: updateSchedule[:id]).where(user_id: userId)
    updateScheduleContentId = updateSchedule.schedule_content.id

    # transaction張りたい
    @scheduleContent = Hash.new
    @scheduleContent = ScheduleContent.find_by(id: updateScheduleContentId)
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
      # date: updateSchedule[:date], #日付も更新する仕様の場合。ごっちゃんから受け取らない場合は、本メソッドでinsertSchedule[:started_at]から取得
      content_id: updateScheduleContentId,
      schedule_content_id: updateScheduleContentId,
      updated_at: DateTime.now
    )
  end

  def insertSchedule(userId, insertSchedule)
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
      date: insertSchedule[:date], #ごっちゃんから受け取らない場合は、本メソッドでinsertSchedule[:started_at]から取得
      user_id: userId,
      content_id: insertedScheduleContent.id,
      schedule_content_id: insertedScheduleContent.id,
      created_at: DateTime.now,
      updated_at: DateTime.now
    )
    @schedule.save
  end

  def deleteSchedule(userId, selectedDeleteScheduleId, isDeleteAll = 1)
    Schedule.joins(:schedule_content) #TODO:updateScheduleでも使っているので、getScheduleContentIdメソッドを作りたい。
    selectedDeleteSchedule = Hash.new
    selectedDeleteSchedule = Schedule.where(id: selectedDeleteScheduleId).where(user_id: userId)
    deleteScheduleContentId = selectedDeleteSchedule.schedule_content.id

    if isDeleteAll == 1
      Schedule.joins(:schedule_content)
      @schedule = Schedule.where(id: deleteScheduleContentId)
      @schedule.delete_all
    else
      @schedule = Schedule.find_by(id: deleteScheduleId)
      @schedule.delete
    end

    @scheduleContent = ScheduleContent.find_by(id: deleteScheduleContentId)
    @scheduleContent.delete
  end
end

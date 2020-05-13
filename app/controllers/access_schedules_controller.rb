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

  def updateSchedule(scheduleInfo)
    ActiveRecord::Base.transaction do # transaction張りたい
      scheduleForId = Schedule.where(id: scheduleInfo[:id], user_id: scheduleInfo[:user_id])
      scheduleContentId = scheduleForId[0].content_id

      scheduleContent = ScheduleContent.find_by(id: scheduleContentId)
      scheduleContent.update!(
        title: scheduleInfo[:title],
        started_at: scheduleInfo[:started_at],
        ended_at: scheduleInfo[:ended_at],
        detail: scheduleInfo[:detail],
        updated_at: DateTime.now
      )

      schedule = Schedule.find_by(id: scheduleInfo[:id])
      schedule.update!(
        date: scheduleInfo[:date],
        content_id: scheduleContentId,
        updated_at: DateTime.now
      )

    rescue ActiveRecord::RecordInvalid => e
      errorMessage = nil
      e.record.errors.messages.each_value do |messages|
        messages.each do |message|
          if errorMessage.nil?
            errorMessage = message
          end
        end
      end
      return errorMessage
    end
    return nil
  end

  def insertSchedule(scheduleInfo)
    ActiveRecord::Base.transaction do # transaction張りたい
      errorMessages = {}
      insScheduleContent = ScheduleContent.create(
        title: scheduleInfo[:title],
        started_at: scheduleInfo[:started_at],
        ended_at: scheduleInfo[:ended_at],
        detail: scheduleInfo[:detail],
        created_at: DateTime.now,
        updated_at: DateTime.now
      )
      if insScheduleContent.valid? == false
        errorMessages.deep_merge!(insScheduleContent.errors)
        raise ActiveRecord::Rollback
      end

      insertedScheduleContentId = ScheduleContent.last.id
      insSchedule = Schedule.create(
        date: scheduleInfo[:date],
        user_id: scheduleInfo[:user_id],
        content_id: insertedScheduleContentId,
        created_at: DateTime.now,
        updated_at: DateTime.now
      )
      if insSchedule.valid? == false
        errorMessages.deep_merge!(insSchedule.errors)
        raise ActiveRecord::Rollback
      end

    rescue => e
      errorMessage = nil
      errorMessages.each_value do |messages|
        messages.each do |message|
          if errorMessage.nil?
            errorMessage = message
          end
        end
      end
      return errorMessage
    end
  end

  def deleteSchedule(ids)
    ActiveRecord::Base.transaction do # transaction張りたい
      selectedDeleteScheduleId = ids[:id]
      isDeleteAll = 1
      userId = ids[:user_id]

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
    rescue => e
      errorMessage = "予定を削除できませんでした。もう一度試してください。"
      return errorMessage
    end
    return nil
  end
end
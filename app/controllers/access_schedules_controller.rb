class AccessSchedulesController < ApplicationController
  def getSchedule(userId, displayYear, displayMonth)
    lastDay = Date.new(displayYear, displayMonth, -1).day
    dateFrom = format("#{displayYear}-%02d-01", displayMonth)
    dateTo = format("#{displayYear}-%02d-#{lastDay}", displayMonth)

    schedules = Schedule.eager_load(:schedule_content).where(date: dateFrom..dateTo, user_id: userId).order(:date, :started_at, :ended_at, :id)

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
    begin
      ActiveRecord::Base.transaction do
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
      end
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
    begin
      ActiveRecord::Base.transaction do
        ScheduleContent.create!(
          title: scheduleInfo[:title],
          started_at: scheduleInfo[:started_at],
          ended_at: scheduleInfo[:ended_at],
          detail: scheduleInfo[:detail],
          created_at: DateTime.now,
          updated_at: DateTime.now
        )

        Schedule.create!(
          date: scheduleInfo[:date],
          user_id: scheduleInfo[:user_id],
          content_id: ScheduleContent.last.id,
          created_at: DateTime.now,
          updated_at: DateTime.now
        )
      end
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

  def deleteSchedule(ids)
    begin
      ActiveRecord::Base.transaction do
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
      end
    rescue
      errorMessage = "予定を削除できませんでした。もう一度試してください。"
      return errorMessage
    end
    return nil
  end
end
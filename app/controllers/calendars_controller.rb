class CalendarsController < AccessSchedulesController
  def calendar
    require 'date'
    if params[:year].present? && params[:year].present?
      @year = params[:year].to_i
      @month = params[:month].to_i
    else
      @year = Date.today.year
      @month = Date.today.month
    end
    userId = session[:user]["id"]
    @schedules = AccessSchedulesController.new.getSchedule(userId, @year, @month)
  end

  def manipulateSchedule
    userId = session[:user]["id"]
    if params[:kbn] == "add"
      schedule = Hash.new
      schedule[:user_id] = userId
      schedule[:date] = params[:date]
      schedule[:title] = params[:title]
      schedule[:started_at] = params[:started_at]+":00"
      schedule[:ended_at] = params[:ended_at]+":00"
      schedule[:detail] = params[:detail]
      errorMessage = AccessSchedulesController.new.insertSchedule(schedule)
      if !!(errorMessage)
        return redirect_to "/calendar/#{params[:ym]}", alert: errorMessage
      end
      message = "予定を追加しました。"
    elsif params[:kbn] == "edit"
      schedule = Hash.new
      schedule[:user_id] = userId
      schedule[:id] = params[:schedule_id]
      schedule[:date] = params[:date]
      schedule[:title] = params[:title]
      schedule[:started_at] = params[:started_at][0..4]+":00"
      schedule[:ended_at] = params[:ended_at][0..4]+":00"
      schedule[:detail] = params[:detail]
      errorMessage = AccessSchedulesController.new.updateSchedule(schedule)
      if !!(errorMessage)
        return redirect_to "/calendar/#{params[:ym]}", alert: errorMessage
      end
      message = "予定を編集しました。"
    elsif params[:kbn] == "delete"
      ids = Hash.new
      ids[:user_id] = userId
      ids[:id] = params[:schedule_id]
      errorMessage = AccessSchedulesController.new.deleteSchedule(ids)
      if !!(errorMessage)
        return redirect_to "/calendar/#{params[:ym]}", alert: errorMessage
      end
      message = "予定を削除しました。"
    end
    redirect_to "/calendar/#{params[:ym]}", notice: message
  end
end
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
      day = params[:date].split('-')[2].to_i
      schedule = Hash.new
      schedule[:user_id] = userId
      schedule[:date] = params[:date]
      schedule[:title] = params[:title]
      schedule[:detail] = params[:detail]
      unless params["allday-A#{day}".to_sym].nil?
        schedule[:started_at] = ""
        schedule[:ended_at] = ""
        errorMessage = AccessSchedulesController.new.insertSchedule(schedule)
      else
        if !(params[:started_at].empty? || params[:ended_at].empty?)
          schedule[:started_at] = params[:started_at]+":00"
          schedule[:ended_at] = params[:ended_at]+":00"
          errorMessage = AccessSchedulesController.new.insertSchedule(schedule)
        elsif params[:started_at].empty?
          if params[:ended_at].empty?
            errorMessage = "開始時刻/終了時刻 は入力必須項目です。"
          else
            errorMessage = "開始時刻 は入力必須項目です。"
          end
        else
          errorMessage = "終了時刻 は入力必須項目です。"
        end
      end
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
      schedule[:detail] = params[:detail]
      unless params["allday-E#{params[:schedule_id]}".to_sym].nil?
        schedule[:started_at] = ""
        schedule[:ended_at] = ""
        errorMessage = AccessSchedulesController.new.updateSchedule(schedule)
      else
        if !(params[:started_at].empty? || params[:ended_at].empty?)
          schedule[:started_at] = params[:started_at][0..4]+":00"
          schedule[:ended_at] = params[:ended_at][0..4]+":00"
          errorMessage = AccessSchedulesController.new.updateSchedule(schedule)
        elsif params[:started_at].empty?
          if params[:ended_at].empty?
            errorMessage = "開始時刻/終了時刻 は入力必須項目です。"
          else
            errorMessage = "開始時刻 は入力必須項目です。"
          end
        else
          errorMessage = "終了時刻 は入力必須項目です。"
        end
      end
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
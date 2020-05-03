class CalendarsController < AccessSchedulesController
  def calendar
    require 'date'
    if params[:year].present? && params[:year].present?
      @year = params[:year].to_i
      @month = params[:month].to_i
      if @month <= 0
        @year -= 1
        @month = 12
        redirect_to "/calendar/#{@year}/#{@month}"
      end
      if @month >= 13
        @year += 1
        @month = 1
        redirect_to "/calendar/#{@year}/#{@month}"
      end
    else
      @year = Date.today.year
      @month = Date.today.month
    end
    userId = session[:user]["id"]
    @schedules = AccessSchedulesController.new.getSchedule(userId, @year, @month)
  end

  def registerSchedule
    userId = session[:user]["id"]
    if params[:kbn] == "add"
      insertSchedule = Hash.new
      insertSchedule[:user_id] = userId
      insertSchedule[:date] = params[:date]
      insertSchedule[:title] = params[:title]
      insertSchedule[:started_at] = params[:started_at]+":00"
      insertSchedule[:ended_at] = params[:ended_at]+":00"
      insertSchedule[:detail] = params[:detail]
      AccessSchedulesController.new.insertSchedule(insertSchedule)
    elsif params[:kbn] == "edit"
      updateSchedule = Hash.new
      updateSchedule[:user_id] = userId
      updateSchedule[:id] = params[:schedule_id]
      updateSchedule[:date] = params[:date]
      updateSchedule[:title] = params[:title]
      updateSchedule[:started_at] = params[:started_at][0..4]+":00"
      updateSchedule[:ended_at] = params[:ended_at][0..4]+":00"
      updateSchedule[:detail] = params[:detail]
      AccessSchedulesController.new.updateSchedule(updateSchedule)
    elsif params[:kbn] == "delete"
      deleteSchedule = Hash.new
      deleteSchedule[:user_id] = userId
      deleteSchedule[:id] = params[:schedule_id]
      AccessSchedulesController.new.deleteSchedule(deleteSchedule)
    end
    redirect_to "/calendar/#{params[:ym]}"
  end
end
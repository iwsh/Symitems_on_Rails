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
    @userId = 2
    @schedules = AccessSchedulesController.new.getSchedule(@userId,@year,@month)
    # use session later
    # session[:schedule] = @schedules[15].schedule_content
  end

  def inputSchedule
    @insertSchedule = ScheduleContent.new
  end

  def registerSchedule
    @insertSchedule = Hash.new
    @insertSchedule[:date] = params[:started_at].to_date
    @insertSchedule[:title] = params[:title]
    @insertSchedule[:started_at] = params[:started_at]
    @insertSchedule[:ended_at] = params[:ended_at]
    @insertSchedule[:detail] = params[:detail]
    AccessSchedulesController.new.insertSchedule(@insertSchedule)
  end

  def edit
    @schedules = AccessSchedulesController.new.getSchedule(@userId,@year,@month)
  end


  def update
    @schedule_content = ScheduleContent.find(params[:id])
    @schedule_content.update(params.require(:schedule_content).permit(:title, :stardted_at, :ended_at, :detail))
    redirect_to '/calendar'
  end


  def deleteConfirm
    #@schedule_content = AccessSchedulesController.new.deleteSchedule(1)
    #@schedule_content_id = params[:schedule_content_id]
    #AccessSchedulesController.new.deleteSchedule(@schedule_content_id)
  end
end

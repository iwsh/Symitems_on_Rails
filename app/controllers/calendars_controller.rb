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
  end

  def inputSchedule
    @schedule_content = ScheduleContent.new 
  end

  def registerSchedule
    if params[:id].present?
      @schedule_content = ScheduleContent.find_by(:id => params[:id])
    else
      @schedule_content = ScheduleContent.new
      @schedule_content.title = params[:schedule_content][:title]
      @schedule_content.started_at = params[:schedule_content][:started_at]
      @schedule_content.ended_at = params[:schedule_content][:ended_at]
      @schedule_content.detail = params[:schedule_content][:detail]
      @schedule_content.save
      redirect_to '/calendar' 
    end
  end

  def edit
# test
    if params[:schedule_id].to_i == 1
      @schedule_content = ScheduleContent.new
      @schedule_content.title = 'タイトル!'
      @schedule_content.stardted_at = '2020/02/09 20:00:00'
      @schedule_content.ended_at = '2020/02/09 21:00:00'
      @schedule_content.detail = 'ガストでお勉強する'
    elsif params[:schedule_id].to_i == 2
      @schedule_content = ScheduleContent.new
      @schedule_content.title = 'タイトル2'
      @schedule_content.stardted_at = '2020/02/09 20:00:00'
      @schedule_content.ended_at = '2020/02/09 21:00:00'
      @schedule_content.detail = '家でお勉強する'
    end
#    @schedule_content = ScheduleContent.find(params[:id])
  end

  def update
    @schedule_content = ScheduleContent.find(params[:id])
    @schedule_content.update(params.require(:schedule_content).permit(:title, :stardted_at, :ended_at, :detail))
    redirect_to '/calendar'
  end


  def deleteConfirm #GOTO
  end
end

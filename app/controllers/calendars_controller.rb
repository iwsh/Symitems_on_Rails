class CalendarsController < ApplicationController
  def calendar
    require 'date'
    if params[:year].present? && params[:year].present?
	    @year = params[:year].to_i
	    @month = params[:month].to_i
      if @month <= 0
        @year -= 1
	@month = 12
      end
      if @month >= 13
	@year += 1
	@month = 1
      end
    else
      @year = Date.today.year
      @month = Date.today.month
    end
  end

  def inputSchedule
    @schedule = Schedule.new 
  end

  def registerSchedule
    if params[:id].present?
      @schedule = Schedule.find_by(:id => params[:id])
    else
      @schedule = Schedule.new
      @schedule.title = params[:schedule][:title]
      @schedule.stardted_at = params[:schedule][:stardted_at]
      @schedule.ended_at = params[:schedule][:ended_at]
      @schedule.detail = params[:schedule][:detail]
      @schedule.save
      redirect_to '/calendar' 
    end
  end

  def edit
# test
    if params[:schedule_id].to_i == 1
      @schedule = Schedule.new
      @schedule.title = 'タイトル!'
      @schedule.stardted_at = '2020/02/09 20:00:00'
      @schedule.ended_at = '2020/02/09 21:00:00'
      @schedule.detail = 'ガストでお勉強する'
    elsif params[:schedule_id].to_i == 2
      @schedule = Schedule.new
      @schedule.title = 'タイトル2'
      @schedule.stardted_at = '2020/02/09 20:00:00'
      @schedule.ended_at = '2020/02/09 21:00:00'
      @schedule.detail = '家でお勉強する'
    end
#    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    @schedule.update(params.require(:schedule).permit(:title, :stardted_at, :ended_at, :detail))
    redirect_to '/calendar'
  end


  def deleteConfirm #GOTO
  end
end

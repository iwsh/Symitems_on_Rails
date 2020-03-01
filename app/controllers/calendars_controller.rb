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
  end

  def registerSchedule
    if params[:schedule_id].present?
      @schedule = Schedule.find_by(:schedule_id => params[:schedule_id])
    else
      @schedule = Schedule.new
      @schedule.title = params[:schedule][:title]
      @schedule.stardted_at = params[:schedule][:stardted_at]
      @schedule.ended_at = params[:schedule][:ended_at]
      @schedule.detail = params[:schedule][:detail]
      redirect_to '/calendar' 
    end
  end

  def deleteConfirm #GOTO
  end
end

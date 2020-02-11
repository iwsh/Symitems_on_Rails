class AccessSchedulesController < ApplicationController
  def getSchedule
    if params[:year].present? && params[:year].present?
      @year = params[:year].to_i
      @month = params[:month].to_i
  end

  def updateSchedule #GOTO
  end

  def insertSchedule #GOTO
  end

  def deleteSchedule #GOTO
  end
end

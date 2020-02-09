class AcsessdbsController < ApplicationController
  def getSchedule
    @displayYear = 2020 #TODO:しげから受け取る表示年、数値型で渡される想定
    @displayMonth = 2 #TODO:しげから受け取る表示月、数値型で渡される想定

    @lastDay = Date.new(@displayYear, @displayMonth, -1).strftime
    @dateFrom = format("#{@displayYear}-%02d-01", @displayMonth)
    @dateTo = format("#{@displayYear}-%02d-#{@lastDay}", @displayMonth)

    Schedule.joins(:schedule_content)
    @schedules = Hash.new
    @schedules = Schedule.where("date BETWEEN ? AND ?", @dateFrom, @dateTo)
  end

  def updateSchedule
  end

  def insertSchedule
  end

  def deleteSchedule
  end

end

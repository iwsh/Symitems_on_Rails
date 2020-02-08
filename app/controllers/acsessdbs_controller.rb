class AcsessdbsController < ApplicationController
  def getSchedule
    @displayYear = '2020' #TODO:しげから受け取る表示年
    @displayMonth = '02' #TODO:しげから受け取る表示月

    # @lastDay = Date.new(@displayYear, @displayMonth, 0).day;
    @lastDay = '29' #TODO:暫定対応、月の日数の取得方法検討中

    @getDate = Hash.new
    @getDate[:from] = @displayYear + '-' + @displayMonth + '-01' #TODO:強引すぎるからきれいな書き方を検討したい
    @getDate[:to] = @displayYear + '-' + @displayMonth + '-' + @lastDay #TODO:強引すぎるからきれいな書き方を検討したい

    @schedule = Hash.new
    @schedule = Schedule.joins(:scheduleContents).select("schedules.*, scheduleContents.*").where("date BETWEEN ? AND ?", @getDate[:month], @getDate[:to])
    @schedules = Schedule.all #TODO:schedule_contentの情報が取れない、検討中
  end

  def updateSchedule
  end

  def insertSchedule
  end

  def deleteSchedule
  end


end

class CalendarsController < StabAccessSchedulesController
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
    #user_idとyear/month('%Y/%m')を使ってgetSchedule?
    #下のSQLの結果がもらえるイメージ（表示だけならこれで足りるが、更新など考えるとid系も必要か？）
    #select strftime('%d', date("schedule"."date")) as date, "schedule_content"."title", "schedule_content"."started_at", "schedule_content"."ended_at", "schedule_content"."detail" from "schedule_content" inner join "schedule" on "schedule_content"."id" = "schedule"."content_id" where "schedule"."user_id" = ? and strftime('%Y/%m', date("schedule"."date")) = ? order by "schedule_content"."started_at", "schedule_content"."ended_at";
    @userId = 2
    @schedules = StabAccessSchedulesController.new.getSchedule(@userId,@year,@month)
  end

  def inputSchedule #GOTO
  end

  def registerSchedule #GOTO
  end

  def deleteConfirm #GOTO
  end
end

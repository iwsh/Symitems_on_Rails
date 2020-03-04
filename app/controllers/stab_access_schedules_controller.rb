class StabAccessSchedulesController < ApplicationController
  def getSchedule(userId, year, month)
    testSchedule1 = Hash.new
    testSchedule1[:id] = 1
    testSchedule1[:date] = '2020-02-05'
    testSchedule1[:schedule_content_id] = 1
    testSchedule1[:schedule_content_title] = '第12回シミテムズ'
    testSchedule2 = Hash.new
    testSchedule2[:id] = 2
    testSchedule2[:date] = '2020-02-11'
    testSchedule2[:schedule_content_id] = 3
    testSchedule2[:schedule_content_title] = 'スノーボード'
    @getSchedules = Hash.new
    if userId == 2 && year == 2020 && month == 2
      @getSchedules[5] = testSchedule1
      @getSchedules[11] = testSchedule2
    end
    return @getSchedules
  end
end

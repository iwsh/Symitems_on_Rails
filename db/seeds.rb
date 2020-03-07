# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@scheduleContent = ScheduleContent.new
@scheduleContent.title = 'スノボ'
@scheduleContent.started_at = '2020-02-11 12:00:00'
@scheduleContent.ended_at = '2020-02-11 14:00:00'
@scheduleContent.detail = '滑る'
@scheduleContent.created_at =  DateTime.now
@scheduleContent.updated_at = DateTime.now
@scheduleContent.save

@schedule = Schedule.new
@schedule.date = '2020-02-11'
@schedule.user_id = '2'
@schedule.content_id = '1'
@schedule.schedule_content_id = '1'
@schedule.created_at =  DateTime.now
@schedule.updated_at = DateTime.now
@schedule.save
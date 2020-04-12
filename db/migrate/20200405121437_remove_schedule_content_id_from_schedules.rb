class RemoveScheduleContentIdFromSchedules < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedules, :schedule_content_id, :integer
  end
end

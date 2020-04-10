class AddContentIdToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_reference :schedules, :content, foreign_key: { to_table: :schedule_contents }
  end
end

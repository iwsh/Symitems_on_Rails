class RemoveContentIdFromSchedules < ActiveRecord::Migration[5.2]
  def change
    remove_column :schedules, :content_id, :integer
  end
end

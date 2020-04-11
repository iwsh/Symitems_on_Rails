class ChangeDatatypeEndedAtOfScheduleContents < ActiveRecord::Migration[5.2]
  def change
    change_column :schedule_contents, :ended_at, :string, :limit=>8
  end
end

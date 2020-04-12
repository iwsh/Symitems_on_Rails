class ChangeDatatypeStartedAtOfScheduleContents < ActiveRecord::Migration[5.2]
  def change
    change_column :schedule_contents, :started_at, :string, :limit=>8
  end
end

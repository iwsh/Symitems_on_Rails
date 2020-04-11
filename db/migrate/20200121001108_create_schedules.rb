class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.date :date, null:false
      t.integer :user_id, null:false
      t.integer :content_id, null:true
      t.references :user, foreign_key: true, null:false
      t.references :schedule_content, foreign_key: true, null:false

      t.timestamps
    end

  end
end

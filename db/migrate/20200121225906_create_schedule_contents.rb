class CreateScheduleContents < ActiveRecord::Migration[5.2]
  def change
    create_table :schedule_contents do |t|
      t.string :title, :limit=>50, null:false
      t.datetime :started_at, null:true
      t.datetime :ended_at, null:true
      t.text :detail, null:true

      t.timestamps
    end
  end
end

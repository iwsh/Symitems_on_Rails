# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

# カラム削除のコマンド(migrationファイルを作成し、migrateを実行)
# rails generate migration RemoveScheduleContentIdFromSchedules schedule_content_id:integer
# rails db:migrate

# カラム編集のコマンド(migrationファイルを作成し、migrateを実行。started_at)
# rails g migration ChangeDatatypeStartedAtOfScheduleContents
# ※マイグレーションファイルに追記 -> change_column :schedule_contents, :started_at, :string, :limit=>8
# rails db:migrate

# カラム編集のコマンド(migrationファイルを作成し、migrateを実行。started_at)
# rails g migration ChangeDatatypeEndedAtOfScheduleContents
# ※マイグレーションファイルに追記 -> change_column :schedule_contents, :ended_at, :string, :limit=>8
# rails db:migrate

ActiveRecord::Schema.define(version: 2020_04_05_125033) do

  create_table "schedule_contents", force: :cascade do |t|
    t.string "title", limit: 50, null: false
    t.string "started_at", limit: 8
    t.string "ended_at", limit: 8
    t.text "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.date "date", null: false
    t.integer "user_id", null: false
    t.integer "content_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 20, null: false
    t.string "password", limit: 20, null: false
    t.string "email", limit: 100, null: false
    t.integer "fails_count", default: 0, null: false
    t.datetime "last_login_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end

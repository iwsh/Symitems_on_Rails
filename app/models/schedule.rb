class Schedule < ApplicationRecord
  belongs_to :schedule_content, optional: true, foreign_key: "content_id"
  validates :user_id, presence: true
  validates :date, presence: { message: "日付は入力必須項目です。" }
end

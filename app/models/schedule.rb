class Schedule < ApplicationRecord
    belongs_to :schedule_content, optional: true, foreign_key: "content_id"
    validates :date, :user_id, :content_id, presence: true
end

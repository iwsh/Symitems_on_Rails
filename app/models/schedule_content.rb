class ScheduleContent < ApplicationRecord
    has_many :schedule
    # validates :title, presence: true
    validates :started_at, :ended_at, length: { minimum: 8 }
end

class ScheduleContent < ApplicationRecord
  has_many :schedule
  validates :title, presence: { message: "タイトル は入力必須項目です。" }
  validates :started_at, length: { minimum: 8, message: "開始時刻 は入力必須項目です。" }
  validates :ended_at, length: { minimum: 8, message: "終了時刻 は入力必須項目です。" }
  validate :end_is_greater_than_start

  def end_is_greater_than_start
    if started_at[0..1] > ended_at[0..1] || (started_at[0..1] == ended_at[0..1] && started_at[3..4] >= ended_at[3..4])
      errors.add(:ended_at, "終了時刻 は 開始時刻 より後の時刻を設定する必要があります。")
    end
  end
end
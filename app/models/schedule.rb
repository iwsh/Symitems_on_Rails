class Schedule < ApplicationRecord
  belongs_to :schedule_content, optional: true, foreign_key: "content_id"
  validates :user_id, presence: true
  validate :valid_date

  def valid_date
    if date.present? && date.year < 1970
      errors.add(:date, "日付 は 1970年以降に設定する必要があります。")
    end
    unless date.present?
      errors.add(:date, "日付は入力必須項目です。")
    end
  end
end

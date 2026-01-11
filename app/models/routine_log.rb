class RoutineLog < ApplicationRecord
  validates :date, presence: true
  validates :key, presence: true
  validates :position, presence: true

  validates :key, uniqueness: { scope: :date }

  scope :for_date, ->(date) { where(date: date).order(:position) }
end

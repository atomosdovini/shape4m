class RoutineLog < ApplicationRecord
  belongs_to :user
  
  validates :date, presence: true
  validates :key, presence: true
  validates :position, presence: true

  validates :key, uniqueness: { scope: [:date, :user_id] }

  scope :for_date, ->(date, user) { where(date: date, user: user).order(:position) }
end

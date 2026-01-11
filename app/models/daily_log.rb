class DailyLog < ApplicationRecord
  belongs_to :user
  
  validates :date, presence: true
  validates :date, uniqueness: { scope: :user_id }

  def completed_score
    [
      hit_protein,
      hit_calories,
      hit_steps,
      did_workout,
      hit_water,
      hit_sleep
    ].count(true)
  end
end

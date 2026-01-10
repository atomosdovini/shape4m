class DailyLog < ApplicationRecord
  validates :date, presence: true, uniqueness: true

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

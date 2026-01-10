class CreateDailyLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :daily_logs do |t|
      t.date :date
      t.decimal :weight_kg
      t.decimal :waist_cm
      t.boolean :hit_protein
      t.boolean :hit_calories
      t.boolean :hit_steps
      t.boolean :did_workout
      t.boolean :hit_water
      t.boolean :hit_sleep
      t.text :notes

      t.timestamps
    end
  end
end

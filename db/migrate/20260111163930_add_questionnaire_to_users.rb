class AddQuestionnaireToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :height_cm, :integer
    add_column :users, :start_weight_kg, :decimal, precision: 5, scale: 2
    add_column :users, :objective, :string
    add_column :users, :training_days_per_week, :integer
    add_column :users, :questionnaire_completed, :boolean, default: false
  end
end

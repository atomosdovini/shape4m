class CreatePlanConfigurations < ActiveRecord::Migration[7.1]
  def change
    create_table :plan_configurations do |t|
      t.json :data, default: {}
      t.timestamps
    end
  end
end

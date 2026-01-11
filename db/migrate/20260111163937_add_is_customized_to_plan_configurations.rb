class AddIsCustomizedToPlanConfigurations < ActiveRecord::Migration[7.1]
  def change
    add_column :plan_configurations, :is_customized, :boolean, default: false
  end
end

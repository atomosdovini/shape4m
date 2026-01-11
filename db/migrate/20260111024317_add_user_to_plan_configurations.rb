class AddUserToPlanConfigurations < ActiveRecord::Migration[7.1]
  def change
    add_reference :plan_configurations, :user, null: true, foreign_key: true
  end
end

class AddUserToDailyLogs < ActiveRecord::Migration[7.1]
  def change
    add_reference :daily_logs, :user, null: true, foreign_key: true
  end
end

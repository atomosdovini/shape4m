class AddUserToRoutineLogs < ActiveRecord::Migration[7.1]
  def change
    add_reference :routine_logs, :user, null: true, foreign_key: true
  end
end

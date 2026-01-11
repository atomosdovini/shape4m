class CreateRoutineLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :routine_logs do |t|
      t.date :date
      t.string :key
      t.boolean :done
      t.datetime :done_at
      t.integer :position

      t.timestamps
    end
  end
end

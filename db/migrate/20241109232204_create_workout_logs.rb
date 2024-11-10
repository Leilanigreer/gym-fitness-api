class CreateWorkoutLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :workout_logs do |t|
      t.references :routine, foreign_key: true
      t.boolean :completed
      t.date :workout_date
      t.integer :actual_sets
      t.integer :actual_reps
      t.text :notes

      t.timestamps
    end
  end
end

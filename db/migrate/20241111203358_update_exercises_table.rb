class UpdateExercisesTable < ActiveRecord::Migration[7.2]
  def change
    change_table :exercises do |t|
      # Add new columns to match the JSON structure
      t.string :force
      t.string :level
      t.string :mechanic
      t.string :equipment
      t.string :category
      t.text :instructions, array: true, default: []
      t.string :primary_muscles, array: true, default: []
      t.string :secondary_muscles, array: true, default: []
      t.string :images, array: true, default: []
    end
  end
end

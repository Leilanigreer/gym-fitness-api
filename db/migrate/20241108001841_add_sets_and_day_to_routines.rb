class AddSetsAndDayToRoutines < ActiveRecord::Migration[7.2]
  def change
    add_column :routines, :sets, :integer
    add_column :routines, :day, :string
  end
end

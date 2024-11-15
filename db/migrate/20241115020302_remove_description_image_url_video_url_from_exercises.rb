class RemoveDescriptionImageUrlVideoUrlFromExercises < ActiveRecord::Migration[7.2]
  def change
    remove_column :exercises, :description, :text
    remove_column :exercises, :image_url, :text
    remove_column :exercises, :video_url, :text
  end
end

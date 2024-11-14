# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# db/seeds.rb
puts "Starting exercise import..."

file_path = Rails.root.join("db", "data", "exercises.json")

unless File.exist?(file_path)
  puts "Error: exercises.json not found in db/data directory"
  return
end

begin
  json_data = JSON.parse(File.read(file_path))
  imported_count = 0

  puts "Found #{json_data.length} exercises to import"

  json_data.each do |exercise_data|
    exercise = Exercise.find_or_initialize_by(name: exercise_data["name"])

    exercise.update!(
      force: exercise_data["force"],
      level: exercise_data["level"],
      mechanic: exercise_data["mechanic"],
      equipment: exercise_data["equipment"],
      category: exercise_data["category"],
      instructions: exercise_data["instructions"],
      primary_muscles: exercise_data["primaryMuscles"],
      secondary_muscles: exercise_data["secondaryMuscles"],
      images: exercise_data["images"]
    )

    imported_count += 1
    puts "Imported: #{exercise.name}" if imported_count % 5 == 0
  end

  puts "\nSuccessfully imported #{imported_count} exercises!"

rescue StandardError => e
  puts "Error importing exercises: #{e.message}"
  puts e.backtrace
end

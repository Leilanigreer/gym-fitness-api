# lib/tasks/import_exercises.rake
namespace :exercises do
  desc "Import exercises from exercises.json file"
  task import: :environment do
    puts "Starting exercise import..."

    # Path to your JSON file
    file_path = Rails.root.join("db", "data", "exercises.json")

    unless File.exist?(file_path)
      puts "Error: exercises.json not found in db/data directory"
      puts "Please download exercises.json and place it in db/data/"
      return
    end

    begin
      # Read and parse the JSON file
      json_data = JSON.parse(File.read(file_path))
      imported_count = 0

      # Wrap in transaction so if one fails, all fail
      Exercise.transaction do
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
          puts "Imported: #{exercise.name}" if imported_count % 10 == 0
        end
      end

      puts "Successfully imported #{imported_count} exercises!"

    rescue JSON::ParserError => e
      puts "Error parsing JSON file: #{e.message}"
    rescue StandardError => e
      puts "Error importing exercises: #{e.message}"
    end
  end

  desc "Display exercise statistics"
  task stats: :environment do
    puts "\nExercise Database Statistics:"
    puts "----------------------------"
    puts "Total exercises: #{Exercise.count}"
    puts "By category:"
    Exercise.group(:category).count.each do |category, count|
      puts "  #{category}: #{count}"
    end
    puts "\nBy level:"
    Exercise.group(:level).count.each do |level, count|
      puts "  #{level}: #{count}"
    end
    puts "\nBy equipment:"
    Exercise.group(:equipment).count.each do |equipment, count|
      puts "  #{equipment}: #{count}"
    end
  end
end

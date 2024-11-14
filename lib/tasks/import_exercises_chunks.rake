namespace :exercises do
  desc "Import exercises in smaller chunks"
  task import_chunks: :environment do
    puts "Starting exercise import in chunks..."

    file_path = Rails.root.join("db", "data", "exercises.json")

    unless File.exist?(file_path)
      puts "Error: exercises.json not found in db/data directory"
      return
    end

    begin
      json_data = JSON.parse(File.read(file_path))
      imported_count = 0

      puts "Found #{json_data.length} exercises to import"

      # Process in chunks of 5
      json_data.each_slice(5) do |chunk|
        puts "\nProcessing chunk..."

        Exercise.transaction do
          chunk.each do |exercise_data|
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
            puts "Imported: #{exercise.name}"
          end
        end

        puts "Chunk complete - #{imported_count} exercises imported so far"
        sleep(1) # Add a small delay between chunks
      end

      puts "\nSuccessfully imported #{imported_count} exercises!"

    rescue JSON::ParserError => e
      puts "Error parsing JSON file: #{e.message}"
    rescue StandardError => e
      puts "Error importing exercises: #{e.message}"
      puts e.backtrace
    end
  end
end

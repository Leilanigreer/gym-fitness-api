require "json"
require "pg"

puts "Starting import..."

# Read the JSON file
file_path = File.join(__dir__, "db", "data", "exercises.json")
json_data = JSON.parse(File.read(file_path))

# Get database connection info from Railway
db_url = ENV["postgresql://postgres:OXSqNUSlRkFYLrBECxtgDpIldpaHynhW@postgres.railway.internal:5432/railway"]

puts "Connecting to database..."

# Connect to the database
conn = PG.connect(db_url)

puts "Connected! Starting import..."

json_data.each do |exercise|
  begin
    conn.exec_params(
      "INSERT INTO exercises (name, force, level, mechanic, equipment, category, instructions, primary_muscles, secondary_muscles, images, created_at, updated_at)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, NOW(), NOW())
       ON CONFLICT (name) DO UPDATE SET
       force = $2,
       level = $3,
       mechanic = $4,
       equipment = $5,
       category = $6,
       instructions = $7,
       primary_muscles = $8,
       secondary_muscles = $9,
       images = $10,
       updated_at = NOW()",
      [
        exercise["name"],
        exercise["force"],
        exercise["level"],
        exercise["mechanic"],
        exercise["equipment"],
        exercise["category"],
        exercise["instructions"],
        exercise["primaryMuscles"],
        exercise["secondaryMuscles"],
        exercise["images"]
      ]
    )
    puts "Imported: #{exercise['name']}"
  rescue => e
    puts "Error importing #{exercise['name']}: #{e.message}"
  end
end

puts "Import completed!"
conn.close

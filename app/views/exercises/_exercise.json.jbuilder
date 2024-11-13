json.id exercise.id
json.name exercise.name
json.description exercise.description
json.images exercise.images&.map { |image| "/exercises/#{image}" }
json.force exercise.force
json.level exercise.level
json.capital_level exercise.capital_level
json.mechanic exercise.mechanic
json.equipment exercise.equipment
json.capital_equipment exercise.capital_equipment
json.category exercise.category
json.capital_category exercise.capital_category
json.instructions exercise.instructions
json.primary_muscles exercise.primary_muscles
json.capital_primary_muscles exercise.capital_primary_muscles
json.secondary_muscles exercise.secondary_muscles
json.created_at exercise.created_at
json.updated_at exercise.updated_at

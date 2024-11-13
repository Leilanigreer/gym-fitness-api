json.dates @date_range do |date|
  json.date date
  day_name = date.strftime("%A")

  day_routines = @routines_by_day[day_name] || []

  json.routines day_routines do |routine|
    json.id routine.id
    json.exercise_id routine.exercise.id
    json.exercise_name routine.exercise.name
    json.exercise routine.exercise
    json.reps routine.reps
    json.sets routine.sets
    json.day routine.day

    matching_log = @existing_logs[date]&.find { |log| log.routine_id == routine.id }

    json.workout_log do
      if matching_log
        json.id matching_log.id
        json.completed matching_log.completed
        json.actual_sets matching_log.actual_sets
        json.actual_reps matching_log.actual_reps
        json.notes matching_log.notes
        json.workout_date matching_log.workout_date
        json.created_at matching_log.created_at
        json.updated_at matching_log.updated_at
      else
        json.id nil
        json.completed false
        json.actual_sets routine.sets
        json.actual_reps routine.reps
        json.notes nil
        json.workout_date date
        json.created_at nil
        json.updated_at nil
      end
    end
  end
end

json.workout_log do
  json.partial! "workout_logs/workout_log", workout_log: @workout_log

  json.routine do
    json.id @workout_log.routine.id
    json.exercise_id @workout_log.routine.exercise_id
    json.exercise_name @workout_log.routine.exercise.name
    json.reps @workout_log.routine.reps
    json.sets @workout_log.routine.sets
    json.day @workout_log.routine.day
  end
end

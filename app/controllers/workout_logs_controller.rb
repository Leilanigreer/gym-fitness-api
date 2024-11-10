class WorkoutLogsController < ApplicationController
  def index
    @workout_logs = WorkoutLog.all
    render :index
  end

  def create
    @workout_log = WorkoutLog.new(
      routine_id: params[:routine_id],
      completed: params[:completed],
      workout_date: params[:workout_date],
      actual_sets: params[:actual_sets],
      actual_reps: params[:actual_reps],
      notes: params[:notes]
    )
    @workout_log.save
    render :show
  end
end

class WorkoutLogsController < ApplicationController
  def index
    end_date = Date.today
    start_date = end_date - 1.month
    @routines_by_day = Routine.includes(:exercise).group_by(&:day)

    @existing_logs = WorkoutLog.includes(routine: :exercise)
                              .all
                              .group_by(&:workout_date)

    @date_range = ((start_date..end_date).to_a + @existing_logs.keys).uniq.sort
  end

  def create
    puts "Received workout_date: #{params[:workout_date]}" # Keeping your debug line
    @workout_log = WorkoutLog.new(workout_log_params)
    if @workout_log.save
      # Load associated data for the show template
      @workout_log = WorkoutLog.includes(routine: :exercise).find(@workout_log.id)
      render :show
    else
      render json: { errors: @workout_log.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @workout_log = WorkoutLog.find_by(id: params[:id])

    if @workout_log.nil?
      render json: { errors: [ "Workout log not found" ] }, status: :not_found
      return
    end

    if @workout_log.update(workout_log_params)
      # Load associated data for the show template
      @workout_log = WorkoutLog.includes(routine: :exercise).find(@workout_log.id)
      render :show
    else
      render json: { errors: @workout_log.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def workout_log_params
    params.require(:workout_log).permit(
      :routine_id,
      :workout_date,
      :completed,
      :actual_sets,
      :actual_reps,
      :notes
    )
  end
end

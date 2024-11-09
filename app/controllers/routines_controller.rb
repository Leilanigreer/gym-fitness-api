class RoutinesController < ApplicationController
  def index
    @routines = Routine.all
    render :index
  end

  def create
    @routine = Routine.new(
      user_id: current_user.id,
      exercise_id: params[:exercise_id],
      reps: params[:reps],
      sets: params[:sets],
      day: params[:day]
    )
    @routine.save
    render :show
  end

  def update
    @routine = Routine.find_by(id: params[:id])
    if @routine.update(
      reps: params[:reps] || routine.reps,
      sets: params[:sets] || routine.sets,
      day: params[:day] || routine.day,
    )
    render :show
    else
      render json: { errors: @routine.errors.full_message }, status: :unprocessable_entity
    end
  end
end

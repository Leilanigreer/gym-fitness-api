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
end

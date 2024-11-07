class ExercisesController < ApplicationController
  def index
    @exercises = Exercise.all
    render :index
  end

  def show
    @exercise = Exercise.find_by(id: params[:id])
    render :show
  end
end

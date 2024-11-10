class ExercisesController < ApplicationController
def index
  @exercises = Exercise.includes(:routines)
  render json: @exercises.map { |exercise|
    {
      id: exercise.id,
      name: exercise.name,
      description: exercise.description,
      image_url: exercise.image_url,
      video_url: exercise.video_url,

      scheduled_days: current_user ?
        exercise.routines
          .where(user_id: current_user.id)
          .group_by(&:day)
          .transform_values(&:count) :
      nil
    }
  }
end

  def show
    @exercise = Exercise.find_by(id: params[:id])
    render :show
  end
end

class ExercisesController < ApplicationController
  def index
    @exercises = Exercise.includes(:routines)
    render json: @exercises.map { |exercise|
      {
        id: exercise.id,
        name: exercise.name,
        description: exercise.description,
        images: exercise.images&.map { |image| "/exercises/#{image}" },
        force: exercise.force,
        level: exercise.level,
        capital_level: exercise.capital_level,
        mechanic: exercise.mechanic,
        equipment: exercise.equipment,
        capital_equipment: exercise.capital_equipment,
        category: exercise.category,
        capital_category: exercise.capital_category,
        instructions: exercise.instructions,
        primary_muscles: exercise.primary_muscles,
        secondary_muscles: exercise.secondary_muscles,
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

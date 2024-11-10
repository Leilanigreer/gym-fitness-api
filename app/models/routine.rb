class Routine < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  has_many :workout_logs
end

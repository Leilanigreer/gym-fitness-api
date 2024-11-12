class Exercise < ApplicationRecord
  has_many :routines

  def capital_level
    level.capitalize()
  end

  def capital_category
    category.capitalize()
  end

  def capital_equipment
    equipment.capitalize()
  end
end

class Route < ActiveRecord::Base
  belongs_to :address

  def turn_enum
    ['Morning', 'Evening', 'Night']
  end

end

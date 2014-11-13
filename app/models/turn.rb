class Turn < ActiveRecord::Base
  belongs_to :school

  serialize :arrival,  Tod::TimeOfDay
  serialize :departure, Tod::TimeOfDay

  def arrival=(t)
    @arrival = TimeOfDay.parse(t)
  end

  def departure=(t)
    @departure = TimeOfDay.parse(t)
  end
end

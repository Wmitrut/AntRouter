class Turn < ActiveRecord::Base
  belongs_to :school

  def turn_enum
    ['Morning', 'Evening', 'Night']
  end

  def turn_type
    return :morning if self.arrival > "06:00" and self.departure < "12:00"
    return :evening if self.arrival > "12:00" and self.departure < "18:00"
    return :night if self.arrival > "18:00" and self.departure < "23:00"
  end

  

end

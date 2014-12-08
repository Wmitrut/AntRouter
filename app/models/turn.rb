class Turn < ActiveRecord::Base
  belongs_to :school, inverse_of: :turns

  scope :morning, -> {
    where("arrival > '06:00'").where("departure < '12:00'").
      where("school_id in (select school_id from students where students.turn = 0)")
  }
  scope :evening, -> {
    where("arrival > '12:00'").where("departure < '18:00'").
      where("school_id in (select school_id from students where students.turn = 1)")
  }
  scope :night, -> {
    where("arrival > '18:00'").where("departure < '23:59'").
      where("school_id in (select school_id from students where students.turn = 2)")
  }

  def turn_enum
    ['Morning', 'Evening', 'Night']
  end

  def turn_type
    return :morning if self.arrival > "06:00" and self.departure < "12:00"
    return :evening if self.arrival > "12:00" and self.departure < "18:00"
    return :night if self.arrival > "18:00" and self.departure < "23:59"
  end

  def address
    school.address
  end
  def name
    "#{school.name} :: #{arrival} - #{departure}"
  end

end

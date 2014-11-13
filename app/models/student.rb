class Student < ActiveRecord::Base
  belongs_to :address
  belongs_to :school
  accepts_nested_attributes_for :address, :allow_destroy => true
  validates_presence_of :address

  scope :morning, -> {
    joins(:school => :turns).where("turns.arrival > '06:00'").where("turns.departure < '12:00'")
  }
  scope :evening, -> {
    joins(:school => :turns).where("turns.arrival > '12:00'").where("turns.departure < '18:00'")
  }
  scope :night, -> {
    joins(:school => :turns).where("turns.arrival > '18:00'").where("turns.departure < '23:59'")
  }

  def turn_enum
    ['Morning', 'Evening', 'Night']
  end

end

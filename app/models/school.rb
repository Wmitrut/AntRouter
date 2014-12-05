class School < ActiveRecord::Base
  belongs_to :address
  has_many :turns
  accepts_nested_attributes_for :address, :allow_destroy => true

  scope :morning, -> {
    joins(:turns).where("turns.arrival > '06:00'").where("turns.departure < '12:00'").
      where("schools.id in (select school_id from students where students.turn = 0)")
  }
  scope :evening, -> {
    joins(:turns).where("turns.arrival > '12:00'").where("turns.departure < '18:00'").
      where("schools.id in (select school_id from students where students.turn = 1)")
  }
  scope :night, -> {
    joins(:turns).where("turns.arrival > '18:00'").where("turns.departure < '23:59'").
      where("schools.

      id in (select school_id from students where students.turn = 2)")
  }

  validates :name, :address, presence: true

  def turn_enum
    ['Morning', 'Evening', 'Night']
  end



end

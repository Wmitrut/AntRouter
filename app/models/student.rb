class Student < ActiveRecord::Base
  belongs_to :address
  belongs_to :school
  has_many :item_routes, as: :routable
  accepts_nested_attributes_for :address, :allow_destroy => true
  validates_presence_of :address

  scope :morning, -> {
    #joins(:school => :turns).where("turns.arrival > '06:00'").where("turns.departure < '12:00'")
    where("turn = 0")
  }
  scope :evening, -> {
    #joins(:school => :turns).where("turns.arrival > '12:00'").where("turns.departure < '18:00'")
    where("turn = 1")
  }
  scope :night, -> {
    #joins(:school => :turns).where("turns.arrival > '18:00'").where("turns.departure < '23:59'")
    where("turn = 2")
  }

  def turn_enum
    [['Morning', '0'], ['Evening', '1'], ['Night', '2']]
  end

  rails_admin do
    edit do
      field :name
      field :address
      field :school
      field :turn
      field :item_routes do
        visible do
           false
        end
      end
    end
  end

end

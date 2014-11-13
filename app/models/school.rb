class School < ActiveRecord::Base
  belongs_to :address
  has_many :turns
  accepts_nested_attributes_for :address, :allow_destroy => true

  validates :name, :address, :arrival, presence: true

  def turn_enum
    ['Morning', 'Evening', 'Night']
  end



end

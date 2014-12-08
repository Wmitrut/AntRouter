class Route < ActiveRecord::Base
  belongs_to :address
  has_many :item_routes, dependent: :destroy, inverse_of: :route
  accepts_nested_attributes_for :item_routes, :allow_destroy => true

  def turn_enum
    ['Morning', 'Evening', 'Night']
  end

  def name
    "#{id}"
  end

end

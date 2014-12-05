class ItemRoute < ActiveRecord::Base
  belongs_to :route, inverse_of: :item_routes
  belongs_to :routable, polymorphic: true

  def to_s
    routable.name
  end

  def name
    "#{order} - #{routable.name}" 
  end

  def address
    routable.address
  end

end

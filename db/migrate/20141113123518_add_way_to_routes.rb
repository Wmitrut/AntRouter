class AddWayToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :way, :integer
  end
end

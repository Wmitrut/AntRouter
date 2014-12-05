class CreateItemRoute < ActiveRecord::Migration
  def change
    create_table :item_routes do |t|
      t.references :route, index: true
      t.integer :order
      t.references :routable, polymorphic: true
    end
  end
end

class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.references :address, index: true

      t.timestamps
    end
  end
end

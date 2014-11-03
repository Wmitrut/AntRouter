class CreateStartpoints < ActiveRecord::Migration
  def change
    create_table :startpoints do |t|
      t.references :address, index: true

      t.timestamps
    end
  end
end

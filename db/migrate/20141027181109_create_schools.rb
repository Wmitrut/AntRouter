class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.references :address, index: true
      t.integer :arrival

      t.timestamps
    end
  end
end

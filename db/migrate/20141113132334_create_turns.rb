class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.references :school, index: true
      t.string :arrival
      t.string :departure

      t.timestamps
    end
  end
end

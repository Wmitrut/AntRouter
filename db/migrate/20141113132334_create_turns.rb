class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.references :school, index: true
      t.time :arrival
      t.time :departure

      t.timestamps
    end
  end
end

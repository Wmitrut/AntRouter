class AddTurnToStudents < ActiveRecord::Migration
  def change
    add_column :students, :turn, :integer
  end
end

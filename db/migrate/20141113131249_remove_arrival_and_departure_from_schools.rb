class RemoveArrivalAndDepartureFromSchools < ActiveRecord::Migration
  def change
    remove_column :schools, :departure, :float
    remove_column :schools, :arrival, :float
  end
end

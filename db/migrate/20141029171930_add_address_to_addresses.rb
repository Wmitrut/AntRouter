class AddAddressToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :address, :string
  end
end

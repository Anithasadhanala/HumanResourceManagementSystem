class ModifyAddressTable < ActiveRecord::Migration[7.1]
  def change

        remove_column :addresses, :address_type, :string
        add_column :addresses, :is_permanent, :boolean, default: true, null: false


  end
end

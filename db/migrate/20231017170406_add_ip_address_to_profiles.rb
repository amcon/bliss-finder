class AddIpAddressToProfiles < ActiveRecord::Migration[7.0]
  def up
    add_column :profiles, :ip_address, :string
  end

  def down
    remove_column :profiles, :ip_address
  end
end

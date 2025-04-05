class AddAdminToOrganizations < ActiveRecord::Migration[8.0]
  def change
    add_column :organizations, :admin_user_id, :integer
  end
end

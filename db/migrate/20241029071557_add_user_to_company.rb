class AddUserToCompany < ActiveRecord::Migration[8.0]
  def change
    add_column :companies, :user_id, :integer
    add_index :companies, :user_id
  end
end
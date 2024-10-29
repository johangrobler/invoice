class AddUserToInvoice < ActiveRecord::Migration[8.0]
  def change
    add_column :invoices, :user_id, :integer
    add_index :invoices, :user_id
  end
end

class AddTokenToInvoice < ActiveRecord::Migration[8.0]
  def change
    add_column :invoices, :token, :string
    add_index :invoices, :token
  end
end

class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.references :company, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.date :invoice_date
      t.string :invoice_no
      t.decimal :amount
      t.text :notes
      t.string :status

      t.timestamps
    end
  end
end

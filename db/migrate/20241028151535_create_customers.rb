class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.text :address
      t.string :email
      t.string :phone
      t.string :reg_no
      t.string :vat_no
      t.string :contact

      t.timestamps
    end
  end
end

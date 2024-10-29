class CreateCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address
      t.string :reg_no
      t.string :phone
      t.string :email
      t.string :contact
      t.references :bank, null: false, foreign_key: true
      t.string :account_number

      t.timestamps
    end
  end
end

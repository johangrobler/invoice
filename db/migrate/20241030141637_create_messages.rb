class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.references :user, null: false, foreign_key: true
      t.string :subject
      t.string :body
      t.integer :invoice_id
      t.string :status
      t.string :email

      t.timestamps
    end
    add_index :messages, :invoice_id
  end
end

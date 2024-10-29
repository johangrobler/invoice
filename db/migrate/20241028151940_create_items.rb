class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.references :invoice, null: false, foreign_key: true
      t.string :description
      t.decimal :price
      t.decimal :quantity

      t.timestamps
    end
  end
end

class CreateActivities < ActiveRecord::Migration[8.0]
  def change
    create_table :activities do |t|
      t.references :invoice, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :description
      t.string :icon
      t.string :color

      t.timestamps
    end
  end
end

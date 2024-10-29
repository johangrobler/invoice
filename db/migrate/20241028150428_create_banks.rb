class CreateBanks < ActiveRecord::Migration[8.0]
  def change
    create_table :banks do |t|
      t.string :name
      t.string :branch_code

      t.timestamps
    end
  end
end

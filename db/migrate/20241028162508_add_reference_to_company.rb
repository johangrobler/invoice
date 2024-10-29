class AddReferenceToCompany < ActiveRecord::Migration[8.0]
  def change
    add_column :companies, :reference, :string
  end
end

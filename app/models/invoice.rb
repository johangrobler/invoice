class Invoice < ApplicationRecord
  belongs_to :company
  belongs_to :customer
  belongs_to :user
  has_many :items

  validates :invoice_date, presence: true 
end

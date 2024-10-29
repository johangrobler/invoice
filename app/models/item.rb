class Item < ApplicationRecord
  belongs_to :invoice
  belongs_to :user
  after_save :invoice_total_price
  validates :description, presence: true
  validates :price, presence: true
  validates :quantity, presence: true

  def total_price
    quantity * price
  end

  def invoice_total_price
    invoice.update(amount: invoice.items.sum("quantity * price"))
  end
end

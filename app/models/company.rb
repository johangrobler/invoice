class Company < ApplicationRecord
  belongs_to :bank
  belongs_to :user


  validates :name, presence: true
  validates :address, presence: true
  validates :email, presence: true
  validates :phone, presence: true
end

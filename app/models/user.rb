class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  validates :first_name, presence: true
  validates :last_name, presence: true   
  validates :phone, presence: true      

  has_many :invoices
  has_many :companies
  has_many :customers
  has_many :items
end

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :invoice

  def send_invoice_email

    UserMailer.invoice_email(self).deliver_now 
  end
end

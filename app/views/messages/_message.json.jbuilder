json.extract! message, :id, :user_id, :subject, :body, :invoice_id, :status, :email, :created_at, :updated_at
json.url message_url(message, format: :json)

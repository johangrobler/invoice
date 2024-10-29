json.extract! invoice, :id, :company_id, :customer_id, :invoice_date, :invoice_no, :amount, :notes, :status, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)

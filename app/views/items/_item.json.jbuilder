json.extract! item, :id, :invoice_id, :description, :price, :quantity, :created_at, :updated_at
json.url item_url(item, format: :json)

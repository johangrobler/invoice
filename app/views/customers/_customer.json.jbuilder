json.extract! customer, :id, :name, :address, :email, :phone, :reg_no, :vat_no, :contact, :created_at, :updated_at
json.url customer_url(customer, format: :json)

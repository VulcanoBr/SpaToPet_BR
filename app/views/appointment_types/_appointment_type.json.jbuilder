json.extract! appointment_type, :id, :payment_required, :name, :user_id, :price, :description, :created_at, :updated_at
json.url appointment_type_url(appointment_type, format: :json)
json.description appointment_type.description.to_s

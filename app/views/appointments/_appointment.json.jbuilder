json.extract! appointment, :id, :status, :user_id, :appointment_type_id, :start_at, :end_at, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)

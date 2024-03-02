json.extract! payment, :id, :billing_status, :user_id, :appointment_id, :created_at, :updated_at
json.url payment_url(payment, format: :json)

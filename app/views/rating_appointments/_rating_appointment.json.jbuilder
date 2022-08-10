json.extract! rating_appointment, :id, :user_id, :rate, :appointment_id, :created_at, :updated_at
json.url rating_appointment_url(rating_appointment, format: :json)

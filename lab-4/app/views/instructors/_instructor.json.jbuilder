json.extract! instructor, :id, :instructor_name, :instructor_email, :meeting_id, :created_at, :updated_at
json.url instructor_url(instructor, format: :json)

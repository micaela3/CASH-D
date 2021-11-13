json.extract! meeting, :id, :start_time, :end_time, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :location, :section_id, :created_at, :updated_at
json.url meeting_url(meeting, format: :json)

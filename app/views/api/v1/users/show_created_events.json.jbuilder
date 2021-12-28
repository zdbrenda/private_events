json.events @created_events do |event|
    json.id event.id
    json.attendees event.attendees do |attendee|
        json.username attendee.username
    end
    json.event_date event.event_date
    json.locaion event.location
end
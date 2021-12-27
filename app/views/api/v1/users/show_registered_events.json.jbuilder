json.events @events do |event|
    json.id event.id
    json.creator do
        json.username event.creator.username
        json.id event.creator.id
    end
    json.event_date event.event_date
    json.locaion event.location
end
class AttendingEventsController < ApplicationController
    def new
        @event = Event.find(params[:id])
    end

    def create
        @event = Event.find(params[:id])
        @event.attendees << current_user
        current_user.attended_events << @event
    end

    private
    def attending_event_params
        params.require(:attending_event).permit(:user_id, :event_id)
    end
end

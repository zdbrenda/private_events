class AttendingEventsController < ApplicationController
    def new
        @event = Event.find(params[:id])
    end

    def create
        @event = Event.find(params[:id])
        @event.attendees << current_user
        current_user.attended_events << @event
        flash[:notice] = "You have registered for the event."
        redirect_to root_path
    end

    def destroy
        @event = Event.find(params[:id])
        @event.attendees.delete(current_user)
        current_user.attended_events.delete(@event) 
        flash[:notice] = "You have deregistered from the event."
        redirect_to root_path
    end

    private
    def attending_event_params
        params.require(:attending_event).permit(:user_id, :event_id)
    end
end

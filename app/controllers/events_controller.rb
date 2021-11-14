class EventsController < ApplicationController
    def index
    end

    def show
        @event = Event.find(params[:id])
    end

    def new
        @event = current_user.created_events.build
    end

    def create
        @event = current_user.created_events.build(event_params)
        respond_to do |format|
            if @event.save
                format.html { redirect_to user_path(current_user.id), notice: "Event was successfully created."}
            else
                format.html { render :new }
            end
        end
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private
    def event_params
        params.require(:event).permit(:event_date, :location)
    end
end

module Api
    module V1
        class EventsController < ApiController
            before_action :set_event, only: [:show, :update, :destroy, :show_attendees, :register, :deregister]
            before_action :authorize_event, only: [:update, :destroy]
            def index
                @events = Event.all
            end

            def show
                @event = Event.find(params[:id])
            end

            def create
                @event = @user.created_events.build(event_params)

                if @event.save
                    render :show, status: :created
                else
                    render json: {message: @event.errors.full_messages}, status: :unprocessable_entity
                end
            end

            def update
                if  @event.update(event_params)
                    render :show, status: :ok
                else
                    render json: {message: @event.errors.full_messages}, status: :unprocessable_entity
                end
            end

            def destroy
                @event.destroy
                render :show, status: :ok
            end

            def show_attendees
                @attendees = @event.attendees
            end

            def register
                if @event.creator != @user && !@event.attendees.include?(@user)
                    @event.attendees << @user
                    render :show, status: :ok
                else
                    render json: {message: "You can't register an event that you have created or you have already registered."}, status: :forbidden
                end
            end

            def deregister
                if (@event.creator.id != @user.id) && (@event.attendees.include?(@user))
                    @event.attendees.delete(@user)
                    render :show, status: :ok
                else
                    render json: {message: "You can't diregister an event that you have created or you have not registered."}, status: :forbidden
                end
            end

            private
            def set_event
                @event = Event.find(params[:id])
            end


            def event_params
                params.require(:event).permit(:event_date, :location)
            end

            def authorize_event
                render json: {message: "Unauthorized"}, status: :unauthorized unless @user == @event.creator
            end
        end
    end
end
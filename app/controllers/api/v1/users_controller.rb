module Api
    module V1
        class UsersController < ApiController
            before_action :authorize_user, only: [:update, :show_registered_events]
            def show
            end

            def update
                if @user.update(user_params)
                    render :show, status: :ok
                else
                    render json: {message: @user.errors.full_messages}, status: :unprocessable_entity
                end
            end

            def show_registered_events
                @events = @user.attended_events
            end

            private
            
            def user_params
                params.require(:user).permit(:id, :username, :email)
            end

            def authorize_user
                # debugger
                render json: {message: "Unauthorized"}, status: :unauthorized unless @user.id == params[:id].to_i
            end
        end
    end
end
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def github
        @user = User.from_omniauth(request.env["omniauth.auth"].select{|k,v| k=="email"})
        if @user.present?
            sign_out_all_scopes
            flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Github'
            sign_in_and_redirect @user, event: :authentication 
             
        else
            session["devise.github_data"] = request.env["omniauth.auth"]
            flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Github'
            redirect_to new_user_registration_url 
        end
    end

    def google_oauth2
        @user = User.from_omniauth(request.env["omniauth.auth"].select{|k,v| k== "email"})
        if @user.persisted?
            sign_in_and_redirect @user, event: :authentication
            set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
        else
            session["devise.google_oauth2_data"] = request.env["omniauth.auth"]
            flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google'
            redirect_to new_user_registration_url
        end
    end

    def failure
        redirect_to root_path
    end

end
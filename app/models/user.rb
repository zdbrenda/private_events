class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github google_oauth2]
  has_many :created_events, class_name: "Event", foreign_key: "creator_id", dependent: :destroy
  has_many :attending_events, dependent: :destroy
  has_many :attended_events, through: :attending_events, source: :event,  foreign_key: "attendee_id"

  def self.from_omniauth(auth)
    
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.password_confirmation = user.password
      user.username = auth.info.name
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
      if data = session["devise.google_oauth2"] && session["devise.google_oauth2_data"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end

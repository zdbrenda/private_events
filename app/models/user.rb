class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github google_oauth2]
  has_many :created_events, class_name: "Event", foreign_key: "creator_id", dependent: :destroy
  has_many :attending_events, dependent: :destroy
  has_many :attended_events, through: :attending_events, source: :event,  foreign_key: "attendee_id"
  encrypts :private_api_key
  blind_index :private_api_key

  before_create :set_private_api_key

  validates :private_api_key, uniqueness: true, allow_blank: true

  def self.from_omniauth(auth)
    data = auth.info
    user = User.where(email: data["email"]).first
    unless user
        user=User.create(username: data['nickname'],
          email: data["email"],
          password: Devise.friendly_token[0,20],
          provider: auth.provider,
          uid:      auth.uid
        )
    end
    user
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

  private

  def set_private_api_key
    self.private_api_key = SecureRandom.hex if self.private_api_key.nil?
  end
end

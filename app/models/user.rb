class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :created_events, class_name: "Event", foreign_key: "creator_id"
  has_many :attending_events
  has_many :attended_events, through: :attending_events, source: :event,  foreign_key: "attendee_id"
end

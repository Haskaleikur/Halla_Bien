class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :events, foreign_key: 'organisator_id', class_name: "Event", dependent: :destroy
    has_many :participations, foreign_key: 'attendee_id', class_name: "Participation", dependent: :destroy
    has_many :events, through: :participations 

    after_create :welcome_send

    def welcome_send
        UserMailer.welcome_email(self).deliver_now
    end
end

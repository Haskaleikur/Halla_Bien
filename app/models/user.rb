class User < ApplicationRecord
    has_many :events
    has_many :participations

    after_create :welcome_send

    def welcome_send
        UserMailer.welcome_email(self).deliver_now
    end
end

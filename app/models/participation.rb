class Participation < ApplicationRecord
    belongs_to :event
    belongs_to :attendee, class_name: "User"

    after_create :new_attendee

    def new_attendee
        AttendeeMailer.attendee_email(organisator).deliver_now
    end
end

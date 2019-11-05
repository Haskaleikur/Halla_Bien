class AttendeeMailer < ApplicationMailer
    default from: 'no-reply@monsite.fr'

    def attendee_email

        @organisator = Event.last.organisator.first_name
        @attendee = Participation.last.attendee.first_name
        @event = Participation.last.event.title

        @url  = 'http://monsite.fr/login'

        #on définit une variable @url qu'on utilisera dans la view d’e-mail
        mail(to: @.email, subject: 'Bienvenue chez nous !')
        
      end
end

class AttendeeMailer < ApplicationMailer
    default from: 'no-reply@monsite.fr'

    def attendee_email (user, event)
      
      #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
      @user = user
      @event = event

      #on définit une variable @url qu'on utilisera dans la view d’e-mail
      @url  = 'http://monsite.fr/login'

      # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
      mail(to: @user.email, subject: 'Merci de vous être inscrit')

        
      end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Faker::Config.locale = 'fr'

User.destroy_all
Event.destroy_all
Participation.destroy_all


#Création de Users

30.times do 
    User.create(email: Faker::Internet.email, password: Faker::Lorem.characters(number: 10, min_alpha: 4, min_numeric: 1), description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
end

#Création d'Events

10.times do
    Event.create(start_date: Faker::Date.forward(days: 23), duration: 5*rand(1..1000),description: Faker::Lorem.paragraph(sentence_count: 5), title: Faker::Quotes::Shakespeare.king_richard_iii_quote, price: Faker::Number.within(range: 1..100), location: Faker::Address.city, organisator_id: User.all.sample.id)
end

#Créer des Participations
30.times do 
    Participation.create(attendee_id: User.all.sample.id, event_id: Event.all.sample.id)
end



class Event < ApplicationRecord

    validates :start_date, presence: true
    validate :start_must_be_future
    validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 } 
    validate :duration_must_be_multiple_of_5
    validates :description, presence: true, length: { in: 20..1000 }
    validates :price, presence: true, length: { in: 1..1000 }
    validates :location, presence: true

    belongs_to :organisator, class_name: "User"
    has_many :participations, dependent: :destroy
    has_many :attendees, through: :participations, class_name: "User"


    private

    #Valider que la date de début est bien dans le futur

  def start_must_be_future
    return if start_date.blank? #On sort de la boucle si start_date est vide
    
    if start_date < Time.now
      errors.add(:start_date, "cannot be past")
    end
  end

  #Duration is multiple of 5
  def duration_must_be_multiple_of_5
    return if duration.blank? #On sort si la fonction est vide

    if duration % 5 != 0
      errors.add(:duration, "Duration has to be multiple of 5")
    end

  end

end

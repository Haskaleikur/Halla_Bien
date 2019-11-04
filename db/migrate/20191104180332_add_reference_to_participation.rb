class AddReferenceToParticipation < ActiveRecord::Migration[5.2]
  def change
    add_reference :participations, :attendee, foreign_key: { to_table: :users }
    add_reference :participations, :event, foreign_key: true
  end
end

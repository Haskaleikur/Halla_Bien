class AddReferenceToEvent < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :organisator, foreign_key: { to_table: :users }
  end
end

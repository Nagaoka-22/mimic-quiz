class AddRoomsToVotes < ActiveRecord::Migration[6.1]
  def change
    add_reference :votes, :room, null: false, foreign_key: true
  end
end

class AddHeroToRooms < ActiveRecord::Migration[6.1]
  def change
    add_reference :rooms, :hero, foreign_key: { to_table: :users }
  end
end

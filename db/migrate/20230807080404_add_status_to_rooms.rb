class AddStatusToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :status, :integer, default: 0, null: false, limit: 1
  end
end

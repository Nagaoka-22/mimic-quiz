class RemoveUsePasswordFromRooms < ActiveRecord::Migration[6.1]
  def change
    remove_column :rooms, :use_password, :boolean
  end
end

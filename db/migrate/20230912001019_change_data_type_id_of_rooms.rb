class ChangeDataTypeIdOfRooms < ActiveRecord::Migration[6.1]
  def up
    change_column :rooms, :id, :string
  end

  def down
    change_column :rooms, :id, :integer
  end
end

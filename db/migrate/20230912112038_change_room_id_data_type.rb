class ChangeRoomIdDataType < ActiveRecord::Migration[6.1]
  def up
    change_column :members, :room_id, :string
    change_column :questions, :room_id, :string
    change_column :votes, :room_id, :string
  end

  def down
    change_column :members, :room_id, :integer
    change_column :questions, :room_id, :integer
    change_column :votes, :room_id, :integer
  end
end

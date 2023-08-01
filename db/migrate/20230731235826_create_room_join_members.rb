class CreateRoomJoinMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :room_join_members do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
    add_index :room_join_members, [:user_id, :room_id], unique: :true
  end
end

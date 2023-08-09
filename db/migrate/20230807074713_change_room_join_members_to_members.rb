class ChangeRoomJoinMembersToMembers < ActiveRecord::Migration[6.1]
  def change
    rename_table :room_join_members, :members
  end
end

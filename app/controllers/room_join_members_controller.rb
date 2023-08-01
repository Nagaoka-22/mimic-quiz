class RoomJoinMembersController < ApplicationController
  def create
    @room = Room.find(params[:id])
    current_user.room_join_members_rooms(@room)
  end

  def destroy
    @room = Room.find(params[:room_id])
    current_user.cancel_room_join_members(@room)
    redirect_to rooms_path, flash: {success: 'ルームから退出しました'}
  end
end

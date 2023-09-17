class MembersController < ApplicationController
  before_action :set_room

  def create
    current_user.join_members_rooms(@room)
  end

  def destroy
    current_user.cancel_members(@room)
    redirect_to rooms_path, flash: { success: 'ルームから退出しました' }
  end

  private

  def set_room
    @room = Room.find_by(id: params[:room_id])
  end
end

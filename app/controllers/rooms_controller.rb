class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.all.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.new(room_params)
    if @room.save
      current_user.add_members(@room)
      redirect_to room_path(@room), flash: {success: 'ルームが作成されました'}
    else
      flash.now[:danger] = 'ルーム作成に失敗しました'
      render :new
    end
  end

  def show
    @room = Room.find(params[:id])
    if !current_user.members?(@room)
      redirect_to enter_room_path(@room)
    end

    members = Member.where(room_id: @room).pluck(:user_id)
    @members = User.find(members)
    @total_members = User.find(members).count
  end

  def destroy
    room = current_user.rooms.find(params[:id])
    room.destroy!
    redirect_to rooms_path, flash: {success: 'ルームを解散しました'}
  end

  def enter
    @room = Room.find(params[:id])
  end

  def pass
    @room = Room.find(params[:id])
    if room_params[:enter_password] == @room.password
      current_user.join_members(@room)
      redirect_to room_path(@room)
    else
      redirect_to rooms_path, flash: {alert: 'パスワードが違います'}
    end
  end

  private
  
  def room_params
    params.require(:room).permit(:title, :password, :enter_password)
  end
end

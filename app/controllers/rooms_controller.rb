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
      redirect_to room_path(@room), flash: {success: 'ルームが作成されました'}
    else
      flash.now[:danger] = 'ルーム作成に失敗しました'
      render :new
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  def destroy
    room = current_user.rooms.find(params[:id])
    room.destroy!
    redirect_to rooms_path, flash: {success: 'ルームを解散しました'}
  end

  private
  
  def room_params
    params.require(:room).permit(:title, :use_password, :password)
  end
end

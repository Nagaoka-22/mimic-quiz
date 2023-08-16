class RoomsController < ApplicationController
  before_action :set_room, except: %i[index new create]
  before_action :set_members, only: %i[show]

  def index
    @rooms = Room.all.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.new(room_params)
    @room.hero_id = current_user.id # 仮
    if @room.save
      current_user.join_members(@room)
      redirect_to room_path(@room), flash: {success: 'ルームが作成されました'}
    else
      flash.now[:danger] = 'ルーム作成に失敗しました'
      render :new
    end
  end

  def show
    if !current_user.members?(@room) && @room.playing?
      redirect_to rooms_path, flash: {success: '募集が締め切られています'}
    elsif !current_user.members?(@room) && @room.ready?
      redirect_to enter_room_path(@room)
    end
    
    if current_user.members?(@room) && @room.latest_question.present?
      redirect_to room_question_path(@room, @room.latest_question)
    end
  end

  def destroy
    @room.destroy!
    redirect_to rooms_path, flash: {success: 'ルームを解散しました'}
  end

  def enter
    if @room.playing?
      redirect_to rooms_path, flash: {success: '募集が締め切られています'}
    end
  end

  def pass
    if enter_params[:enter_password] == @room.password
      current_user.join_members(@room)
      redirect_to room_path(@room)
    else
      redirect_to rooms_path, flash: {alert: 'パスワードが違います'}
    end
  end

  def setting
    @room.playing!
    if @room.update(setting_params)
      redirect_to new_room_question_path(@room)
    end
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def set_members
    @members = @room.members
  end

  def require_join_members!
    redirect_back_or_to root_path, alert: "ルームに参加していません"  unless current_user.members?(@room)
  end
  
  def room_params
    params.require(:room).permit(:title, :password)
  end

  def enter_params
    params.require(:room).permit(:enter_password)
  end

  def setting_params
    params.require(:room).permit(:hero_id)
  end
end

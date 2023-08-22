class RoomsController < ApplicationController
  before_action :set_room, except: %i[index new create]
  before_action :set_members, only: %i[show]

  def index
    join_room_ids = Member.where(user_id: current_user).pluck(:room_id)
    @rooms = Room.where(id: join_room_ids).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.new(room_params)
    if @room.save
      current_user.join_members(@room)
      redirect_to room_path(@room), flash: {success: 'ルームが作成されました'}
    else
      flash.now[:danger] = 'ルーム作成に失敗しました'
      render :new
    end
  end

  def show
    unless current_user.members?(@room)
      redirect_to enter_room_path(@room)
    else
      redirect_to room_question_path(@room, @room.latest_question) if @room.latest_question.present?
    end
  end

  def destroy
    @room.destroy!
    redirect_to rooms_path, flash: {success: 'ルームを解散しました'}
  end

  def enter
    redirect_to rooms_path, flash: {success: '募集が締め切られています'} unless @room.ready?
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
    if @room.update(setting_params)
      redirect_to new_room_question_path(@room)
    end
  end

  def finish
    @room.result!
    redirect_to result_room_path(@room), flash: {success: '最終結果です'}
    # ↑を消してアクションケーブルでページリロード
  end

  def result
    redirect_to room_question_path(@room, @room.latest_question), flash: {alert: 'まだゲーム中です'} unless @room.result?
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def set_members
    @members = @room.members
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

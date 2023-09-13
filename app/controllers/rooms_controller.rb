class RoomsController < ApplicationController
  before_action :set_room, except: %i[index new create search]
  before_action :set_members, only: %i[show]
  before_action :require_normal_user, only: %i[enter pass]

  def index
    @join_room_ids = Member.where(user_id: current_user).pluck(:room_id)
    @rooms = Room.where(id: @join_room_ids).includes(:user).order(created_at: :desc).page(params[:page])
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
    if current_user.members?(@room)
      redirect_to room_path(@room)
    elsif !@room.ready?
      redirect_to rooms_path, flash: { success: '募集が締め切られています' }
    end
  end

  def pass
    if enter_params[:enter_password] == @room.password
      current_user.join_members(@room)
      redirect_to room_path(@room)
    else
      redirect_to enter_room_path(@room), flash: {alert: 'パスワードが違います'}
    end
  end

  def setting
    if @room.update(setting_params)
      redirect_to new_room_question_path(@room)
    end
  end

  def finish
    @room.result!
    # redirect_to result_room_path(@room), flash: {success: '最終結果です'}
    # ↑を消してアクションケーブルでページリロード
    ActionCable.server.broadcast 'phase_channel', {room: @room.id}
  end

  def result
    redirect_to room_question_path(@room, @room.latest_question), flash: {alert: 'まだゲーム中です'} unless @room.result?

    @members = @room.members.sort_by{|member| member.result(@room)}.reverse
  end

  def search
    redirect_to enter_room_path(search_params[:room_id])
  end

  private

  def set_room
    @room = Room.find_by(id: params[:id])

    if @room.nil?
       redirect_to root_path, alert: "指定されたルームが見つかりませんでした。"
    end
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

  def search_params
    params.permit(:room_id)
  end

  def require_normal_user
    if current_user.guest_user?
        redirect_to root_path, alert: 'ゲストユーザーはルームに参加できません'
    end
  end
end

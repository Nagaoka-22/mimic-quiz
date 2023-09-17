class QuestionsController < ApplicationController
  before_action :set_room
  before_action :set_members, only: %i[show update]
  before_action :set_question, except: %i[new create]
  before_action :require_owner!, only: %i[new create]
  before_action :require_creater!, only: %i[ask]

  def new
    if @room.latest_question.present? && !@room.latest_question.result?
      redirect_to room_question_path(@room, @room.latest_question)
    end

    @question = Question.new
    @members = @room.members_without_hero
  end

  def create
    @question = Question.new(question_params)
    @room.playing! unless @room.playing?
    return unless @question.save

    ActionCable.server.broadcast 'phase_channel', { room: @room.id }
  end

  def show
    if @room.result?
      redirect_to result_room_path(@room)
    elsif @room.playing?
      latest_question
    end

    @answer = Answer.new
    @answers = @question.answers

    @vote = Vote.new
    @votes = @question.votes
  end

  def ask
    @question.answer!
    return unless @question.update(content: question_params[:content])

    ActionCable.server.broadcast 'phase_channel', { room: @room.id }
  end

  def vote
    @question.vote!
    ActionCable.server.broadcast 'phase_channel', { room: @room.id }
  end

  def result
    @question.result!
    ActionCable.server.broadcast 'phase_channel', { room: @room.id }
  end

  private

  def set_room
    @room = Room.find_by(id: params[:room_id])
  end

  def set_members
    @members = @room.members
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:user_id, :room_id, :content)
  end

  def latest_question
    return if @question.id == @room.latest_question.id

    redirect_to room_question_path(@room, @room.latest_question)
  end

  def require_owner!
    return if current_user.owner?(@room)

    redirect_to room_path(@room), flash: { success: '管理者権限が必要です' }
  end

  def require_creater!
    return if current_user.id == @question.user.id

    redirect_to room_path(@room), flash: { success: '管理者権限が必要です' }
  end
end

class QuestionsController < ApplicationController
    before_action :set_room
    before_action :set_members, only: %i[show update]
    before_action :set_question, except: %i[new create]
    # 管理者のみnew, create
    # 問題作成車のみupdate

    def new
        @question = Question.new
        @members = @room.members_without_hero
    end

    def create
        @question = Question.new(question_params)
        if @question.save
            redirect_to room_question_path(@room, @question), flash: {success: '出題者が決定しました'}
        else
          flash.now[:danger] = '出題者が決定されていません'
          render :new
        end
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

    def update
        @question.answer!
        if @question.update(content: question_params[:content])
            redirect_to room_question_path(@room, @question), flash: {success: '出題されました'}
        end
    end

    # 投票フェーズにするメソッド
    def vote
        @question.vote!
        redirect_to room_question_path(@room, @question), flash: {success: '投票タイムです'}
        # ↑を消してアクションケーブルでページリロード
    end
    # 結果フェーズにするメソッド
    def result
        @question.result!
        redirect_to room_question_path(@room, @question), flash: {success: '投票結果です'}
        # ↑を消してアクションケーブルでページリロード
    end

    private

    def set_room
        @room = @room = Room.find(params[:room_id])
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
        unless @question.id == @room.latest_question.id
            redirect_to room_question_path(@room, @room.latest_question)
        end
    end
end

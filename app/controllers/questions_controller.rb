class QuestionsController < ApplicationController
    before_action :set_room
    before_action :set_members, only: %i[show update]
    before_action :set_question, only: %i[show update]
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
        unless @question.id == @room.latest_question.id
            redirect_to room_question_path(@room, @room.latest_question)
        end

        @answer = Answer.new
        @answers = @question.answers
    end

    def update
        @question.answer!
        if @question.update(content: question_params[:content])
            redirect_to room_question_path(@room, @question), flash: {success: '出題されました'}
        end
    end

    # 投票フェーズにするメソッド
    # 結果フェーズにするメソッド

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
end

class QuestionsController < ApplicationController
    # 管理者のみnew, create
    # 問題作成車のみupdate

    def new
        @room = Room.find(params[:room_id])
        @question = Question.new

        members = Member.where(room_id: @room).pluck(:user_id).reject { |user_id| user_id == @room.hero_id }
        @members = User.find(members)
    end

    def create
        @room = Room.find(params[:room_id])
        @question = Question.new(user_id: question_params[:user_id], room_id: params[:room_id])
        @question.save
        if @question.save
            redirect_to room_question_path(@room, @question), flash: {success: '出題者が決定しました'}
        else
          flash.now[:danger] = '出題者が決定されていません'
          render :new
        end
    end

    def show
        @room = Room.find(params[:room_id])
        @question = Question.find(params[:id])
        @last_question = Question.where(room_id: @room).order(created_at: :desc).first
        @answer = Answer.new

        unless @question.id == @last_question.id
            redirect_to room_question_path(@room, @last_question)
        end

        members = Member.where(room_id: @room).pluck(:user_id)
        @members = User.find(members)
        @total_members = User.find(members).count

        @answers = Answer.where(question_id: @question).pluck(:id)
        @total_answers = @answers.count
    end

    def update
        @room = Room.find(params[:room_id])
        @question = Question.find(params[:id])
        @question.answer!
        if @question.update(content: question_params[:content])
            redirect_to room_question_path(@room, @question), flash: {success: '出題されました'}
        end
    end

    # 投票フェーズにするメソッド
    # 結果フェーズにするメソッド

    private

    def question_params
        params.require(:question).permit(:user_id, :content)
    end
end

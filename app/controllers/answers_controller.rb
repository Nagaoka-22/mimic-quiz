class AnswersController < ApplicationController
    before_action :set_room
    before_action :set_question

    def create
        if Answer.create(answer_params)
            ActionCable.server.broadcast 'count_channel', {room: @room.id, action: 'answer', count: @question.answers.count}
            redirect_to room_question_path(@room, @question), flash: {success: '回答しました'}
        end
    end

    private

    def answer_params
        params.require(:answer).permit(:content, :user_id, :question_id)
    end

    def set_room
        @room = @room = Room.find(params[:room_id])
    end

    def set_question
        @question = Question.find(params[:question_id])
    end

end

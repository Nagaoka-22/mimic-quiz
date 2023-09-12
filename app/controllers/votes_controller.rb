class VotesController < ApplicationController
    before_action :set_room
    before_action :set_question

    def create
        vote = Vote.new(vote_params)
        if vote.save
            vote.add_point
            vote.correct_point
            
            ActionCable.server.broadcast 'count_channel', {room: @room.id, action: 'vote', count: @question.count_votes}
            redirect_to room_question_path(@room, @question), flash: {success: '投票しました'}
        end
    end

    private

    def set_room
        @room = Room.find_by(id: params[:room_id])
    end

    def set_question
        @question = Question.find(params[:question_id])
    end

    def vote_params
        params.require(:vote).permit(:user_id, :question_id, :answer_id, :room_id)
    end
end
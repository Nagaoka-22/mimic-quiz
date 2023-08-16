class AnswersController < ApplicationController

    def create
        Answer.create(answer_params)
        flash.now[:success] = '回答しました'
    end

    private

    def answer_params
        params.require(:answer).permit(:content, :user_id, :question_id)
    end
end

class Vote < ApplicationRecord
  belongs_to :answer
  belongs_to :user
  belongs_to :question
  belongs_to :room

  validates :user_id, uniqueness: { scope: :question_id }

  def add_point
    answer_user = Answer.find(answer_id).user_id
    member = Member.find_by(room_id: room_id, user_id: answer_user)

    new_point = member.point + 1
    member.update(point: new_point) if answer_user == Room.find(room_id).hero_user.id
  end

  def correct_point
    member = Member.find_by(room_id: room_id, user_id: user_id)

    new_point = member.point + 1
    member.update(point: new_point)
  end
end

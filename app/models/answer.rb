class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :votes, dependent: :destroy

  validates :user_id, uniqueness: { scope: :question_id }

  def own?
    user_id == current_user.id
  end

  def count_votes
    Vote.where(answer_id: id).count
  end

  def whose
    User.find(user_id).name
  end
end

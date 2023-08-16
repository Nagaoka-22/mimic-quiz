class Question < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_many :questions, dependent: :destroy

  enum phase:{ question: 0, answer: 1, vote: 2, result: 3 }

  validates :user_id, presence: true

  def user
    User.find(user_id)
  end

  def answers
    Answer.where(question_id: id).order(created_at: :desc)
  end
end

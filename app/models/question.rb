class Question < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :votes, dependent: :destroy

  enum phase:{ question: 0, answer: 1, vote: 2, result: 3 }

  validates :user_id, presence: true

  def user
    User.find(user_id)
  end

  def answers
    Answer.where(question_id: id).order(created_at: :desc)
  end

  def count_votes
    Vote.where(question_id: id).count
  end

  def result_votes
    # answers = Answer.where(question_id: id).includes(:votes)
    # answers.sort_by{|answer| answer.count_votes}.reverse
    Answer.where(question_id: id).includes(:votes, :user).order(count_votes: :desc)
  end
end

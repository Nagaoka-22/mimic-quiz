class Room < ApplicationRecord
  belongs_to :user
  has_many :members, dependent: :destroy
  has_many :questions, dependent: :destroy

  enum status:{ready: 0, playing: 1, result: 2 }

  validates :title, presence: true, length: { maximum: 20 }
  validates :password, presence: true, length: { minimum: 3, maximum: 6 }

  def hero_user
    User.find(self.hero_id)
  end

  def members
    User.find(members_id)
  end

  def members_without_hero
    User.find(members_id.reject { |user_id| user_id == hero_id })
  end

  def latest_question
    all_questions.order(created_at: :desc).first
  end

  def count_questons
    all_questions.count
  end

  def result_answers
    all_questions
  end

  def results
    answers = Answer.joins(:question).where( question: { room_id: id }).left_outer_joins(:votes)
    answers.sort_by{|answer| answer.count_votes}.reverse
  end

  def count_total_votes
    all_questions.joins(:votes).count
  end
  
  private
  
    def all_questions
      Question.where(room_id: id)
    end

    def members_id
      Member.where(room_id: id).order(created_at: :desc).pluck(:user_id)
    end
end

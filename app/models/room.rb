class Room < ApplicationRecord
  belongs_to :user
  has_many :members, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :votes, dependent: :destroy

  before_create -> { self.id = SecureRandom.uuid }

  enum status: { ready: 0, playing: 1, result: 2 }

  validates :title, presence: true, length: { maximum: 20 }
  validates :password, presence: true, length: { minimum: 3, maximum: 6 }

  def hero_user
    User.find(hero_id)
  end

  def members
    User.find(members_id)
  end

  def members_without_hero
    User.find(members_id.reject { |user_id| user_id == hero_id })
  end

  def latest_question
    all_questions.order(created_at: :desc).take
  end

  def count_questions
    all_questions.count
  end

  def result_answers
    all_questions
  end

  def result_members
    Member.where(room_id: id).order(point: :desc)
  end

  private

  def all_questions
    Question.where(room_id: id)
  end

  def members_id
    Member.where(room_id: id).order(created_at: :asc).pluck(:user_id)
  end
end

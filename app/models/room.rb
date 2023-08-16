class Room < ApplicationRecord
  belongs_to :user
  has_many :members, dependent: :destroy
  has_many :questions, dependent: :destroy

  enum status:{ready: 0, playing: 1 }

  validates :title, presence: true, length: { maximum: 20 }
  validates :password, presence: true, length: { minimum: 3, maximum: 6 }

  def hero_user
    User.find(self.hero_id)
  end

  def members
    members_id = Member.where(room_id: id).order(created_at: :desc).pluck(:user_id)
    User.find(members_id)
  end

  def members_without_hero
    members_id = Member.where(room_id: id).order(created_at: :desc).pluck(:user_id).reject { |user_id| user_id == hero_id }
    User.find(members_id)
  end

  def latest_question
    Question.where(room_id: id).order(created_at: :desc).first
  end

  def questons_count
    Question.where(room_id: id).count
  end
end

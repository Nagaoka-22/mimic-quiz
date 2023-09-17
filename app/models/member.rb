class Member < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :user_id, uniqueness: { scope: :room_id }

  def name
    User.find(user_id).name
  end
end

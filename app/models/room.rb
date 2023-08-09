class Room < ApplicationRecord
  belongs_to :user
  has_many :members, dependent: :destroy

  enum status:{ready: 0, playing: 1 }

  validates :title, presence: true, length: { maximum: 20 }
  validates :password, presence: true, length: { minimum: 3, maximum: 6 }
end

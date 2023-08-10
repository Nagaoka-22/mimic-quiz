class Question < ApplicationRecord
  belongs_to :room
  belongs_to :user

  enum phase:{ question: 0, answer: 1, vote: 2, result: 3 }

  validates :user_id, presence: true
end

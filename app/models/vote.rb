class Vote < ApplicationRecord
  belongs_to :answer
  belongs_to :user
  belongs_to :question
  belongs_to :room

  validates :user_id, uniqueness: { scope: :question_id }
end

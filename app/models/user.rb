class User < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :members_rooms, through: :members, source: :room
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, presence: true, length: { maximum: 10 }

  def owner?(room)
    room.user_id == id
    # 後でroom.user.nameとなっている（N+1）を解消する
  end

  def join_members(room)
    members_rooms << room
    ActionCable.server.broadcast 'entry_channel', {name: self.name, id: self.id}
  end

  def cancel_members(room)
    members_rooms.delete(room)
    ActionCable.server.broadcast 'entry_channel', {id: self.id}
  end

  def members?(room)
    members_rooms.include?(room)
  end

  def hero?(room)
    room.hero_id == id
  end

  def answered?(question)
    Answer.where(question_id: question, user_id: self.id).exists?
  end

  def answer(question)
    Answer.find_by(question_id: question, user_id: id)
  end

  def voted?(question)
    votes = Vote.where(question_id: question, user_id: self.id).exists?
  end

  def voted_answer(question)
    answer = Vote.find_by(question_id: question, user_id: id)
    Answer.find_by(id: answer.id)
  end
end

class User < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :members_rooms, through: :members, source: :room

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
end

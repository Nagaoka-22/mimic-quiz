class User < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :room_join_members, dependent: :destroy
  has_many :room_join_members_rooms, through: :room_join_members, source: :room

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, presence: true, length: { maximum: 10 }

  def owner?(room)
    room.user_id == id
    # 後でroom.user.nameとなっている（N+1）を解消する
  end

  def room_join_members(room)
    room_join_members_rooms << room
  end

  def cancel_room_join_members(room)
    room_join_members_rooms.delete(room)
  end

  def room_join_members?(room)
    room_join_members_rooms.include?(room)
  end
end

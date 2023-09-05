class AddPointsToMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :point, :integer, null: false, default: 0
  end
end

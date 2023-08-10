class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.references :room, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :content
      t.integer :phase, default: 0, null: false, limit: 1

      t.timestamps
    end
  end
end

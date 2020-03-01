class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :location
      t.string :vibe
      t.string :description
      t.string :skill_level
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end

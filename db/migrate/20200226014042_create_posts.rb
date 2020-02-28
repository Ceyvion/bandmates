class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :location
      t.boolean :has_band
      t.boolean :need_band
      t.string :description
      t.belongs_to :user 

      t.timestamps null: false
    end
  end
end

class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :customer_id, null: false
      t.string :title, null: false
      t.float :star, default: 0
      t.timestamps
    end
  end
end

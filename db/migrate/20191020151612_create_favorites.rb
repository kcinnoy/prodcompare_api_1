class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.string :title
      t.string :price
      t.string :image
      t.string :item_type
      t.string :ref_id
      t.string :url
      t.bigint :user_id, null: false
      t.integer :num_favorers, default: 0

      t.timestamps
    end
    add_index :favorites, :ref_id
  end
end

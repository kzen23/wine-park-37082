class CreateWineArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :wine_articles do |t|
      t.string :wine_name,     null: false
      t.string :wine_name_kana
      t.integer :wine_price,       null: false
      t.string :wine_shop,         null: false
      t.string :title,             null: false
      t.text    :comment,          null: false
      t.integer :wine_type_id,     null: false
      t.integer :wine_taste_id,    null: false
      t.references :user,          null: false, foreign_key: true
      t.timestamps
    end
  end
end

class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.integer :user_follows_id
      t.integer :user_followed_id
      t.timestamps
    end
  end
end

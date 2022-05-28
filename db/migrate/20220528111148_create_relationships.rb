class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.integer :follows_user_id
      t.integer :followed_user_id
      t.timestamps
    end
  end
end

class CreateBattleHashtags < ActiveRecord::Migration
  def change
    create_table :battle_hashtags do |t|
      t.integer :hashtag_id
      t.integer :battle_id

      t.timestamps
    end
  end
end

class RemoveBattleIdFromHashtag < ActiveRecord::Migration
  def change
    remove_column :hashtags, :battle_id, :integer
  end
end

class CreateHashtags < ActiveRecord::Migration
  def change
    create_table :hashtags do |t|
      t.string :title
      t.integer :battle_id

      t.timestamps
    end
  end
end

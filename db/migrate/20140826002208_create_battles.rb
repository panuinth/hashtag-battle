class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.string :name

      t.timestamps
    end
  end
end

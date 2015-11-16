class CreatePlayerTimes < ActiveRecord::Migration
  def change
    create_table :player_times do |t|
      t.integer :game_id
      t.integer :player_id
      t.time :in_time
      t.time :out_time

      t.timestamps
    end
  end
end

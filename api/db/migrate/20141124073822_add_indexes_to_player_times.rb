class AddIndexesToPlayerTimes < ActiveRecord::Migration
  def change
    add_index :player_times, :game_id
    add_index :player_times, :player_id
  end
end

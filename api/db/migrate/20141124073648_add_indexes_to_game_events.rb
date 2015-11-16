class AddIndexesToGameEvents < ActiveRecord::Migration
  def change
    add_index :game_events, :game_id
    add_index :game_events, :player_id
  end
end

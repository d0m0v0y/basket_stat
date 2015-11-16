class RenameGameEventsToGameEvent < ActiveRecord::Migration
  def change
    rename_table :game_events, :game_event
  end
end

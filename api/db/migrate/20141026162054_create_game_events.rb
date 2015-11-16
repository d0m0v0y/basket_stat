class CreateGameEvents < ActiveRecord::Migration
  def change
    create_table :game_events do |t|
      t.integer :game_id
      t.integer :player_id
      t.string :event_code
      t.time :event_time

      t.timestamps
    end
  end
end

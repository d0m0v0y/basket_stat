class CreateLineupTable < ActiveRecord::Migration
  def change
    create_table :lineups do |t|
      t.integer :game_id, index: true
      t.integer :team_id
      t.integer :player_id
    end
  end
end

class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.integer :player_id
      t.integer :game_id
      t.integer :team_id
      t.time :played_time
      t.integer :points
      t.integer :free_throw_attempts
      t.integer :free_throw_made
      t.decimal :free_throw_percent
      t.integer :field_goal_attempts
      t.integer :field_goal_made
      t.decimal :field_goal_percent
      t.integer :three_point_attempts
      t.integer :three_point_made
      t.decimal :three_point_percent
      t.integer :assists
      t.integer :blockshots
      t.integer :offencive_rebounds
      t.integer :deffencive_rebounds
      t.integer :losses
      t.integer :steels
      t.integer :fouls
      t.integer :fouls_commited
      t.decimal :efficiency
    end
  end
end

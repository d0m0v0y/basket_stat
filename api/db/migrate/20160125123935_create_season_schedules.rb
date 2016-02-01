class CreateSeasonSchedules < ActiveRecord::Migration
  def change
    create_table :season_schedules do |t|
      t.integer :day
      t.references :season, index: true, foreign_key: true
      t.datetime :scheduled_at
      t.references :game, index: true, foreign_key: true
      t.integer :home_team_id
      t.integer :away_team_id

      t.timestamps null: false
    end
    add_index :season_schedules, :scheduled_at
  end
end

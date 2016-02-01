class CreateSeasonTeams < ActiveRecord::Migration
  def change
    create_table :season_teams do |t|
      t.references :season, index: true, foreign_key: false
      t.references :team, index: true, foreign_key: false

      t.timestamps null: false
    end
  end
end

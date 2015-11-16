class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.date :date
      t.integer :home_team_id
      t.integer :away_team_id

      t.timestamps
    end
  end
end

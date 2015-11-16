class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :team_id
      t.string :first_name
      t.string :last_name
      t.date :bith_date
      t.integer :height
      t.integer :weight
      t.integer :number
      t.integer :position_id

      t.timestamps
    end
  end
end

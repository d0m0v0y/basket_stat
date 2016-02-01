class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.string :name
      t.references :championship, index: true, foreign_key: false

      t.timestamps null: false
    end
  end
end

class RenameBirthDateColumn < ActiveRecord::Migration
  def change
    rename_column :players, :bith_date, :birth_date
  end
end

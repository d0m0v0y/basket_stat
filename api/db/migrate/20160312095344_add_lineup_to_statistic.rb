class AddLineupToStatistic < ActiveRecord::Migration
  def change
    add_column :statistics, :lineup, :boolean, default: false
  end
end

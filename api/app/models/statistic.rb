class Statistic < ActiveRecord::Base
  has_and_belongs_to_many :players
  has_many :teams
  # belongs_to :game
end

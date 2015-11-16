class Statistic < ActiveRecord::Base
  has_many :players
  has_many :teams
  # belongs_to :game
end

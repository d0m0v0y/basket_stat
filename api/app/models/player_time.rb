class PlayerTime < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  scope :to_update, ->(game_id, player_id) {
    where(game_id: game_id)
    .where(player_id: player_id)
    .where('out_time is NULL')
  }

end

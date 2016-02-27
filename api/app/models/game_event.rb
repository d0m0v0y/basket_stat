class GameEvent < ActiveRecord::Base
  belongs_to :game
  belongs_to :player

  enum event_code: {
    ftm: 1,
    fta: 2,
    fgm: 3,
    fga: 4,
    fgm3: 5,
    fga3: 6,
    ast: 7,
    blk: 8,
    orb: 9,
    drb: 10,
    los: 11,
    stl: 12,
    pf: 13,
    pfc: 14
  }

  validates :event_time, :game_id, :player_id, presence: true
  validates :event_code, inclusion: {in: GameEvent.event_codes}

  scope :events_by_code, ->(game_id, event_code) { where(game_id: game_id, event_code: GameEvent.event_codes[event_code]) }

  def count_events_by_code(game_id, event_code)
    self.events_by_code(game_id, event_code).count
  end
end

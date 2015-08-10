class Player < ActiveRecord::Base
  belongs_to :team
  has_many :player_times
  has_many :game_events
  has_many :statistics

  enum position: {
      point_guard: 1,
      shooting_guard: 2,
      small_forward: 3,
      power_forward: 4,
      center: 5
  }

  validates :team_id, :first_name, :last_name, :number,
            :height, :weight,  presence: true

  # scope :events_by_code, ->(game_id, event_code) { where(game_id: game_id, event_code: event_code)}

  # delegate :events_by_code, to: :game_events

  def full_name
    "#{first_name} #{last_name}"
  end

  # def events_by_code(game_id, event_code)
  #   game_events.where(game_id: game_id, event_code: event_code).count
  # end

  def played_time(game_id)
    player_times
      .where(game_id: game_id)
      .select('sum(TIME_TO_SEC(TIMEDIFF(player_times.out_time, player_times.in_time))) as time_in_game')
      .first
      .time_in_game
  end

  def points(game_id)
     total_points = game_events.events_by_code(game_id, GameEvent.event_codes[:ftm]).count +
         2 * game_events.events_by_code(game_id, GameEvent.event_codes[:fgm]).count +
         3 * game_events.events_by_code(game_id, GameEvent.event_codes[:fgm3]).count
    total_points
  end

  def percent(game_id, event_code_attempt, event_code_made)
    attempts_count = events_by_code(game_id, event_code_attempt)
    made_count = events_by_code(game_id, event_code_made)
    (made_count.to_f / (attempts_count + made_count)) * 100.0
  end

  def save_stats(game_id)
    stat = Statistic.new({ player_id: self.id, game_id: game_id, team_id: self.team_id })
    stat.update_attributes stats(game_id)
  end

  def stats(game_id)
    {
      # played_time: played_time(game_id),
      points: points(game_id),
      free_throw_attempts: events_by_code(game_id, GameEvent.event_codes[:fta]),
      free_throw_made: events_by_code(game_id, GameEvent.event_codes[:ftm]),
      free_throw_percent: percent(game_id, GameEvent.event_codes[:fta], GameEvent.event_codes[:ftm]),
      field_goal_attempts: events_by_code(game_id, GameEvent.event_codes[:fga]),
      field_goal_made: events_by_code(game_id, GameEvent.event_codes[:fgm]),
      field_goal_percent: percent(game_id, GameEvent.event_codes[:fga], GameEvent.event_codes[:fgm]),
      three_point_attempts: events_by_code(game_id, GameEvent.event_codes[:fga3]),
      three_point_made: events_by_code(game_id, GameEvent.event_codes[:fgm3]),
      three_point_percent: percent(game_id, GameEvent.event_codes[:fga3], GameEvent.event_codes[:fgm3]),
      assists: events_by_code(game_id, GameEvent.event_codes[:ast]),
      blockshots: events_by_code(game_id, GameEvent.event_codes[:blk]),
      offencive_rebounds: events_by_code(game_id, GameEvent.event_codes[:orb]),
      deffencive_rebounds: events_by_code(game_id, GameEvent.event_codes[:drb]),
      losses: events_by_code(game_id, GameEvent.event_codes[:los]),
      steels: events_by_code(game_id, GameEvent.event_codes[:stl]),
      fouls: events_by_code(game_id, GameEvent.event_codes[:pf]),
      fouls_commited: events_by_code(game_id, GameEvent.event_codes[:pfc]),
      efficiency: efficiency(game_id)
    }
  end

  def efficiency(game_id)
    eff = (points(game_id) + events_by_code(game_id, GameEvent.event_codes[:ast]) +
        1.4 * events_by_code(game_id, GameEvent.event_codes[:stl]) +
        1.2 * events_by_code(game_id, GameEvent.event_codes[:drb]) +
        1.4 * events_by_code(game_id, GameEvent.event_codes[:orb]) +
        0.5 * events_by_code(game_id, GameEvent.event_codes[:pfc]) +
        1.2 * events_by_code(game_id, GameEvent.event_codes[:blk]) -
        events_by_code(game_id, GameEvent.event_codes[:fga]) -
        1.5 * events_by_code(game_id, GameEvent.event_codes[:fga3]) -
        0.8 * events_by_code(game_id, GameEvent.event_codes[:fta]) -
        1.4 * events_by_code(game_id, GameEvent.event_codes[:los]) -
        events_by_code(game_id, GameEvent.event_codes[:pf]) ) #/ (played_time(game_id)/60.0)
    eff.round(2)
  end

end

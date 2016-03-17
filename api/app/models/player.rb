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

  delegate :events_by_code, to: :game_events

  def full_name
    "#{first_name} #{last_name}"
  end

  def count_events_by_code(game_id, event_code)
    # game_events.where(game_id: game_id, event_code: event_code).count
    events_by_code(game_id, event_code).count
  end

  def played_time(game_id)
    player_times
      .where(game_id: game_id)
      .select('sum(TIME_TO_SEC(TIMEDIFF(player_times.out_time, player_times.in_time))) as time_in_game')
      .first
      .time_in_game
  end

  def points(game_id)
     total_points = events_by_code(game_id, :ftm).count +
         2 * events_by_code(game_id, :fgm).count +
         3 * events_by_code(game_id, :fgm3).count
    total_points
  end

  def percent(game_id, event_code_attempt, event_code_made)
    attempts_count = count_events_by_code(game_id, event_code_attempt)
    puts("attempts_count: #{ event_code_attempt}")
    made_count = count_events_by_code(game_id, event_code_made)
    puts("made_count: #{made_count.inspect}")
    return 0 if (attempts_count + made_count) == 0
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
      free_throw_attempts: count_events_by_code(game_id, :fta),
      free_throw_made: count_events_by_code(game_id, :ftm),
      free_throw_percent: percent(game_id, :fta, :ftm),
      field_goal_attempts: count_events_by_code(game_id, :fga),
      field_goal_made: count_events_by_code(game_id, :fgm),
      field_goal_percent: percent(game_id, :fga, :fgm),
      three_point_attempts: count_events_by_code(game_id, :fga3),
      three_point_made: count_events_by_code(game_id, :fgm3),
      three_point_percent: percent(game_id, :fga3, :fgm3),
      assists: count_events_by_code(game_id, :ast),
      blockshots: count_events_by_code(game_id, :blk),
      offencive_rebounds: count_events_by_code(game_id, :orb),
      deffencive_rebounds: count_events_by_code(game_id, :drb),
      losses: count_events_by_code(game_id, :los),
      steels: count_events_by_code(game_id, :stl),
      fouls: count_events_by_code(game_id, :pf),
      fouls_commited: count_events_by_code(game_id, :pfc),
      efficiency: efficiency(game_id),
      lineup: lineup?(game_id)
    }
  end

  def efficiency(game_id)
    efficiency_table = [
        { event: :ast, multiplier: 1.0 },
        { event: :stl, multiplier: 1.4 },
        { event: :drb, multiplier: 1.2 },
        { event: :orb, multiplier: 1.4 },
        { event: :pfc, multiplier: 0.5 },
        { event: :blk, multiplier: 1.2 },
        { event: :fga, multiplier: -1.0 },
        { event: :fga3, multiplier: -1.5 },
        { event: :fta, multiplier: -0.8 },
        { event: :los, multiplier: -1.4 },
        { event: :pf, multiplier: -1.0 },
    ]
    eff = (points(game_id) +
        efficiency_table.inject(0) do |sum, row|
          sum + row[:multiplier] * count_events_by_code(game_id, row[:event])
        end)
        #/ (played_time(game_id)/60.0)
    eff.round(2)
  end

  def lineup?(game_id)
    Lineup.where(game_id: game_id, team_id: team.id, player_id: id).any?
  end

end

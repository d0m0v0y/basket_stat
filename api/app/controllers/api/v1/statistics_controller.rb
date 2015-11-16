module Api
  module V1
    class StatisticsController < ApiController

      api :GET, '/statistics/:game_id', 'Show statistics for each player of each team'
      formats [:json]
      def show
        @stats = Statistic.where(game_id: params[:game_id])
        respond_with @stats, include: ['games', 'teams']
      end

    end
  end
end

module Api
  module V1
    class StatisticsController < ApiController

      def show
        @stats = Statistic.where(game_id: params[:game_id])
        respond_with @stats, include: ['games', 'teams', 'players']
      end

    end
  end
end

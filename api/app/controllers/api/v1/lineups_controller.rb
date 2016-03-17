module Api
  module V1
    class LineupsController < ApiController
      def show
        @lineup = Lineup.find(params[:id])
        respond_with @lineup
      end

      def index
        @lineup = Lineup.where(game_id: params[:game_id], team_id: params[:team_id])
        respond_with @lineup
      end

      def create
        @lineup = Lineup.new(lineup_params)
        if @lineup.save
          render json: @lineup, status: :created
        else
          render json: @lineup.errors, status: :unprocessable_entity
        end
      end

      private

      def lineup_params
        params.require(:lineup).permit(:game_id, :team_id, :player_id)
      end
    end
  end
end


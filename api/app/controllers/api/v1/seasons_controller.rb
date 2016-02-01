module Api
  module V1
    class SeasonsController < ApiController
      before_action -> { @champ = Championship.find(params.require(:championship_id)) }

      def index
        @seasons = @champ.seasons
        render json: @seasons
      end

      def create
        @season = @champ.seasons.new(season_params)

        if @season.save
          render json: @season, status: :created
        else
          render json: @season.errors, status: :unprocessable_entity
        end
      end

      def show
        @season = @champ.seasons.find(params.require(:id))

        if @season.present?
          render json: @season, status: :ok
        else
          render json: @season, status: :not_found
        end
      end

      def update
        @season = @champ.seasons.where(id: params.require(:id))

        if @season.update_attributes(champ_params)
          render json: @season, status: :accepted
        else
          render json: @season.errors, status: :unprocessable_entity
        end
      end

      private

      def season_params
        params.require(:season).permit(:name)
      end
    end
  end
end

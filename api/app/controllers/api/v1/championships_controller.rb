module Api
  module V1
    class ChampionshipsController < ApiController
      def index
        @champs = Championship.all
        render json: @champs
      end

      def show
        id = params.require(:id)
        @champ = Championship.where(id: id)

        if @champ.present?
          render json: @champ, status: :ok
        else
          render json: @champ, status: :not_found
        end
      end

      def create
        @champ = Championship.new(champ_params)

        if @champ.save
          render json: @champ, status: :created
        else
          render json: @champ.errors, status: :unprocessable_entity
        end
      end

      def update
        @champ = Championship.find(params.require(:id))

        if @champ.update_attributes(champ_params)
          render json: @champ, status: :accepted
        else
          render json: @champ.errors, status: :unprocessable_entity
        end
      end

      private

      def champ_params
        params.require(:championship).permit(:name)
      end
    end
  end
end

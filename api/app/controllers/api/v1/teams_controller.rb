module Api
  module V1
    class TeamsController < ApiController

      def index
        @teams = Team.all
        render json: @teams
      end

      def show
        @team = Team.find(params[:id])
        render json: @team, status: :ok
      end

      def create
        @team = Team.new(team_params)

        if @team.save
          render json: @team, status: :created
        else
          render json: @team.errors, status: :unprocessable_entity
        end
      end

      def update
        @team = Team.find(params[:id])

        if @team.update_attributes(team_params)
          # head :no_content
          render json: @team, status: :accepted
        else
          render json: @team.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @team = Team.find(params[:id])
        @team.destroy
        head :no_content
      end

      def team_params
        params.require(:team).permit(:name, :description)
      end

    end
  end
end


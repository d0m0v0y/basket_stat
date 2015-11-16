module Api
  module V1
    class PlayersController < ApiController

      api :GET, '/players', 'Show list of Players'
      formats [:json]
      param :team_id, :number, :required => false
      def index
        @players = Player.all
        @players = @players.where(team_id: params[:team_id]) if params[:team_id].present?
        render json: @players
      end

      api :GET, '/players/:id', 'Show Player info'
      formats [:json]
      param :id, :number, :required => :true
      def show
        @player = Player.where(id: params[:id])

        if @player.present?
          render json: @player, status: :ok
        else
          render json: @player, status: :not_found
        end
      end

      api :POST, '/players', 'Create Player'
      formats [:json]
      param :player, Hash, :required => true, :action_aware => true do
        param :team_id, :number, :desc => 'Id of team'
        param :first_name, String, :desc => 'First name of the player'
        param :last_name, String, :desc => 'Last name of the player'
        param :birth_date, String, :desc => 'Birth Date of the player in format YYYY-MM-DD'
        param :height, :number, :desc => 'Height of the player'
        param :weight, :number, :desc => 'Weight of the player'
        param :position, Player.positions.keys, :desc => 'Position of the player'
        param :number, :number, :desc => 'Number of player'
      end
      def create
        @player = Player.new(player_params)
        if @player.save
          render json: @player, status: :created
        else
          render json: @player.errors, status: :unprocessable_entity
        end
      end

      api :PATCH, '/players', 'Create Player'
      formats [:json]
      param :player, Hash, :required => true, :action_aware => true do
        param :team_id, :number, :required => false, :desc => 'Id of team'
        param :first_name, String, :required => false, :desc => 'First name of the player'
        param :last_name, String, :required => false, :desc => 'Last name of the player'
        param :birth_date, String, :required => false, :desc => 'Birth Date of the player'
        param :height, :number, :required => false, :desc => 'Height of the player'
        param :weight, :number, :required => false, :desc => 'Weight of the player'
        param :position, Player.positions.keys, :required => false, :desc => 'Position of the player'
        param :number, :number, :required => false, :desc => 'Number of player'
      end
      description <<-EOS
=== Example
curl -X PATCH -H "x-api: true" -H "Content-Type: application/json" -H "Cache-Control: no-cache"  -d '{
  "player":
    {
      "first_name": "Vasya 222",
      "birth_date": "1991-10-24"
    }
}' http://localhost:3000/api/v1/players/2

      EOS
      def update
        @player = Player.find(params[:id])
        if @player.update_attributes(player_params)
          # head :no_content
          render json: @player, status: :accepted
        else
          render json: @player.errors, status: :unprocessable_entity
        end
      end

      api :DELETE, '/players/:id', 'Destroy an Team'
      def destroy
        @player = Player.find(params[:id])
        @player.destroy
        head :no_content
      end

      private

      def player_params
        params.require(:player).permit(:team_id, :first_name, :last_name,
                                       :birth_date, :height, :weight, :position,
                                       :number)
      end

    end
  end
end

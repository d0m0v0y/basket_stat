require 'rails_helper'

describe 'Teams actions'  do
  context 'GET index' do
    it 'returns list of teams ' do
      create_list(:team, 10)

      get '/api/v1/teams.json'

      expect(response).to be_success
      expect(json['teams'].count).to eq 10
    end
  end

  context 'create team request' do
    context 'with valid data' do
      it 'creates new team' do
        team = { team: { name: 'team_1', description: 'descr_1' }}

        post '/api/v1/teams', team , format: :json

        expect(response).to be_success
        expect(json['team']['name']).to eq 'team_1'
      end
    end
  end
end
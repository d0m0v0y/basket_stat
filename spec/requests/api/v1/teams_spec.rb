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

  context 'GET by id' do
    it 'returns json with team info' do
      team = create(:team)

      get "/api/v1/teams/#{team.id}", format: :json

      expect(response).to be_success
      expect(json['team']['name']).to eq team.name
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

    context 'with invalid params' do
      it 'returns error' do
        team = { team: { name: '' } }

        post '/api/v1/teams', team, format: :json

        #expect(response.status).to eq 422
        expect(response).not_to be_success
        expect(json['name']).to include("can't be blank")
      end
    end

    context 'update team' do
      context 'with valid params' do
        it 'updates team info' do
          team = create(:team)

          patch "/api/v1/teams/#{team.id}", {team: {name: 'team_1'}}, format: :json

          expect(response).to be_success
          expect(json['team']['name']).to eq 'team_1'
        end
      end

      context 'with invalid params' do
        it 'return errors' do
          team = create(:team)

          patch "/api/v1/teams/#{team.id}", { team: { name: '' } }, format: :json

          expect(response).not_to be_success
          expect(json['name']).to include("can't be blank")
        end
      end
    end

    context 'delete team' do
      context 'by valid id' do
        it 'return success' do
          teams = create_list(:team, 5)

          delete "/api/v1/teams/#{teams.last.id}", format: :json

          expect(response).to be_success

        end
      end

      context 'by invalid id' do
        it 'return error' do
          teams = create_list(:team, 5)

          delete "/api/v1/teams/#{teams.last.id+10}", format: :json

          expect(response).not_to be_success
        end
      end
    end
  end
end
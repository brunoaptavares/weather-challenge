require 'rails_helper'

RSpec.describe Api::WeatherController, type: :controller do

  describe 'GET #forecast' do

    context 'when city param is empty' do
      let(:param) { nil }

      it 'return error message' do
        get :forecast, params: param

        expect(response.status).to eq 500
      end
    end

    context 'when city param is valid' do
      let(:param) { { city: 'Aruja' } }

      it 'return a forecast' do
        get :forecast, params: param, format: :json

        expect(response.status).to eq 200
      end
    end
  end
end

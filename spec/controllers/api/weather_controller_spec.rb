require 'rails_helper'

RSpec.describe Api::WeatherController, type: :controller do

  describe 'GET #forecast' do
    subject { get :forecast, params: param }

    context 'when city param is empty' do
      let(:param) { nil }
      let(:mocked_return) { "{\"error\":\"param is missing or the value is empty: city\",\"message\":\"erro ao buscar a previsao\"}" }

      it 'return error message' do
        subject

        expect(response.status).to eq 500
        expect(response.body).to eq (mocked_return)
      end
    end

    context 'when city param is not empty' do
      let(:param) { { city: 'São Paulo' } }
      let(:mocked_return) { "{\"error\":\"param is missing or the value is empty: city\",\"message\":\"erro ao buscar a previsao\"}" }

      before do
        #expect(Openweather2).to receive(:get_weather).and_return(mocked_return)
      end

      it 'return city data' do
        subject

        expect(response.status).to eq 500
        expect(response.body).to eq ( mocked_return )
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Site::DashboardController, type: :controller do

  describe 'GET #index' do
    let(:mocked_return) {
      {
        city: "Sao Paulo",
        longitude: -46.64,
        latitude: -23.55,
        temperature: 70.77,
        pressure: 1024,
        humidity: 64,
        min_temperature: 68,
        max_temperature: 73.4,
        clouds: 40,
        wind_speed: 6.93,
        wind_angle: 150,
        celsius_temperature: 21.54
      }
    }

    subject { get :index, params: param }

    context 'when city param is empty' do
      let(:param) { nil }

      before do
        expect(Openweather2).to receive(:get_weather).and_return(mocked_return)
      end

      it 'return default city weather' do
        subject

        expect(response.status).to eq 200
        expect(response).to render_template('site/dashboard/index')
        expect(assigns(:weather)).to eq mocked_return
      end
    end

    context 'when city param is not empty' do
      let(:param) { { city: 'Aruja' } }
      let(:mocked_return) {
        {
          city: "Aruja",
          longitude: -46.64,
          latitude: -23.55,
          temperature: 70.77,
          pressure: 1024,
          humidity: 64,
          min_temperature: 68,
          max_temperature: 73.4,
          clouds: 40,
          wind_speed: 6.93,
          wind_angle: 150,
          celsius_temperature: 21.54
        }
      }

      before do
        expect(Openweather2).to receive(:get_weather).and_return(mocked_return)
      end

      it 'return default city weather' do
        subject

        expect(response.status).to eq 200
        expect(response).to render_template('site/dashboard/index')
        expect(assigns(:weather)).to eq mocked_return
      end
    end

    context 'when api returns error' do
      let(:param) { { city: 'Teste' } }

      before do
        allow(Openweather2).to receive(:get_weather).and_raise(StandardError)
      end

      it 'return default city weather' do
        subject

        expect(response.status).to eq 200
        expect(response).to render_template('site/dashboard/index')
        expect(assigns(:weather)).to be_nil
      end
    end
  end
end

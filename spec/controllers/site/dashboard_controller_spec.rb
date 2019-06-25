require 'rails_helper'

RSpec.describe Site::DashboardController, type: :controller do

  describe 'GET #index' do
    login_user

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

    before do
      allow(Openweather2).to receive(:get_weather).and_return(mocked_return)
    end

    context 'when city param is empty' do
      let(:param) { nil }

      it 'responds successfully with http status 200 and default city weather' do
        get :index, params: param

        expect(response).to have_http_status(200)
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

      it 'responds successfully with http status 200 and the city weather' do
        get :index, params: param

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

      it 'responds with http status 400 and error message' do
        get :index, params: param

        expect(response.status).to eq 400
        expect(response).to render_template('site/dashboard/index')
        expect(assigns(:weather)).to be_nil
      end
    end
  end

  describe 'POST #add_to_bookmarks' do
    login_user

    context 'when receive a valid param' do
      let(:param) { { city: 'Aruja' } }

      before do
        allow_any_instance_of(BookmarkService).to receive(:create!).and_return(Bookmark.new)
      end

      it 'responds successfully with http status 302 and redirect to index page' do
        post :add_to_bookmarks, params: param

        expect(response.status).to eq 302
        expect(response).to redirect_to(site_dashboard_index_path(param))
      end
    end
  end

  describe 'POST #remove_from_bookmarks' do
    login_user

    context 'when receive a valid param' do
      let(:param) { { city: 'Aruja' } }

      before do
        allow_any_instance_of(BookmarkService).to receive(:create!).and_return(Bookmark.new)
      end

      it 'responds successfully with http status 302 and redirect to index page' do
        post :remove_from_bookmarks, params: param

        expect(response.status).to eq 302
        expect(response).to redirect_to(site_dashboard_index_path(param))
      end
    end

    context 'when receive a invalid param' do
      let(:param) { { city: 'Teste' } }

      before do
        allow_any_instance_of(BookmarkService).to receive(:create!).and_return(nil)
      end

      it 'responds successfully with http status 302 and redirect to index page' do
        post :remove_from_bookmarks, params: param

        expect(response.status).to eq 302
        expect(response).to redirect_to(site_dashboard_index_path(param))
      end
    end
  end
end

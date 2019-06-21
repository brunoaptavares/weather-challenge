module Site
  class DashboardController < Site::ApplicationController
    helper WeatherHelper

    def index
      @weather = weather_service.get_weather(city_param)
    rescue
      @weather
    end

    private

    def city_param
      params[:city] || 'Sao Paulo,BR'
    end

    def weather_service
      @weather_service ||= WeatherService.new
    end
  end
end

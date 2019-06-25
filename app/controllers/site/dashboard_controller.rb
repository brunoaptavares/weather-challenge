require 'i18n'

module Site
  class DashboardController < Site::ApplicationController
    helper WeatherHelper

    skip_before_action :verify_authenticity_token, raise: false

    def index
      @bookmarks = bookmark_service.find_user_bookmarks(current_user)
      begin
        @weather     = weather_service.get_weather(city_param)
        @is_bookmark = bookmark_service.is_bookmark?(city_param, current_user.id)
      rescue
        @weather = nil
        render status: 400
      end
    end

    def add_to_bookmarks
      bookmark_service.create!(city_param, current_user.id)
      redirect_to site_dashboard_index_path(city: city_param)
    end

    def remove_from_bookmarks
      bookmark_service.remove_from_bookmarks(city_param, current_user.id)
      redirect_to site_dashboard_index_path(city: city_param)
    end

    private

    def city_param
      I18n.transliterate(params[:city] || 'Sao Paulo').downcase.titleize
    end

    def weather_service
      @weather_service ||= WeatherService.new
    end

    def bookmark_service
      @bookmark_service ||= BookmarkService.new
    end
  end
end

require "i18n"

module Site
  class DashboardController < Site::ApplicationController
    helper WeatherHelper

    skip_before_action :verify_authenticity_token, raise: false

    def index
      @bookmarks = bookmarks_service.find_user_bookmarks(current_user)
      begin
        @weather     = weather_service.get_weather(city_param)
        @is_bookmark = bookmarks_service.is_bookmark?(current_user, city_param)
      rescue
        @weather = nil
      end
    end

    def add_to_bookmarks
      bookmarks_service.create(params.merge(user_id: current_user.id))
      redirect_to site_dashboard_index_path(city: city_param)
    end

    def remove_to_bookmarks
      Bookmarks.where(user_id: current_user.id, city_name: city_param).first.delete
      redirect_to site_dashboard_index_path(city: city_param)
    end

    private

    def city_param
      I18n.transliterate(params[:city] || 'Sao Paulo').downcase.titleize
    end

    def weather_service
      @weather_service ||= WeatherService.new
    end

    def bookmarks_service
      @bookmarks_service ||= BookmarksService.new
    end
  end
end

class BookmarksService
  def create(params)
    Bookmarks.new.tap do |b|
      b.city_name = params[:city]
      b.user_id = params[:user_id]
      b.save
    end
  end
end

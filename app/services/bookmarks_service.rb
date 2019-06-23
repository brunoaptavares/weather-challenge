class BookmarksService
  def create(params)
    Bookmarks.new.tap do |b|
      b.city_name = params[:city]
      b.user_id = params[:user_id]
      b.save
    end
  end

  def find_user_bookmarks(user)
    Bookmarks.where(user_id: user.id)
  end

  def is_bookmark?(user, city_name)
    Bookmarks.where(user_id: user.id, city_name: city_name).present?
  end
end

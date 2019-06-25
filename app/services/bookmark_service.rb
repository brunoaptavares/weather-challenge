class BookmarkService
  def create!(city_name, user_id)
    fail ArgumentError.new('city_name cannot be nil') if city_name.nil?
    fail ArgumentError.new('user_id cannot be nil') if user_id.nil?

    Bookmark.new.tap do |b|
      b.city_name = city_name
      b.user_id = user_id
      b.save
    end
  end

  def find_user_bookmarks(user_id)
    fail ArgumentError.new('user_id cannot be nil') if user_id.nil?

    Bookmark.where(user_id: user_id).order(:city_name)
  end

  def is_bookmark?(city_name, user_id)
    fail ArgumentError.new('city_name cannot be nil') if city_name.nil?
    fail ArgumentError.new('user_id cannot be nil') if user_id.nil?

    Bookmark.where(user_id: user_id, city_name: city_name).present?
  end

  def remove_from_bookmarks(city_name, user_id)
    fail ArgumentError.new('city_name cannot be nil') if city_name.nil?
    fail ArgumentError.new('user_id cannot be nil') if user_id.nil?

    bookmark = Bookmark.where(user_id: user_id, city_name: city_name).first
    bookmark.delete if bookmark.present?
  end
end

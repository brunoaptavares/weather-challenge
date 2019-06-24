class Bookmark < ActiveRecord::Base
  belongs_to :user

  validates :city_name, presence: true, uniqueness: { scope: [:user_id] }
  validates_associated :user
end

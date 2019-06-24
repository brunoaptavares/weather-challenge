require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe 'ActiveRecord specification' do
    it { is_expected.to belong_to(:user) }

    it { is_expected.to have_db_column(:id).of_type(:uuid) }
    it { is_expected.to have_db_column(:city_name).of_type(:text) }

    it { is_expected.to validate_presence_of(:city_name) }
    it { is_expected.to validate_uniqueness_of(:city_name).scoped_to(:user_id) }
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ActiveRecord specification' do
    it { is_expected.to have_many(:bookmark).order(city_name: :asc) }

    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:encrypted_password).of_type(:string) }
    it { is_expected.to have_db_column(:reset_password_token).of_type(:string) }
    it { is_expected.to have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:remember_created_at).of_type(:datetime) }
  end
end

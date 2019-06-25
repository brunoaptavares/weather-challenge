require 'rails_helper'

RSpec.describe BookmarkService, type: :service do
  let(:service)   { described_class.new }
  let(:city_name) { 'Aruja' }
  let(:user_id)   { 1 }

  describe '#create!' do
    subject { service.create!(city_name, user_id) }

    context 'with city param is nil' do
      let(:city_name) { nil }

      specify { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with user_id param is nil' do
      let(:user_id) { nil }

      specify { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with valid params' do

      it { is_expected.to be_an_instance_of Bookmark }
      its([:city_name]) { is_expected.to eq city_name }
      its([:user_id])   { is_expected.to eq user_id }
    end
  end

  describe '#find_user_bookmarks' do
    subject { service.find_user_bookmarks(user_id) }

    context 'with user_id param is nil' do
      let(:user_id) { nil }

      specify { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when bookmarks does not exist' do
      it 'returns nil' do
        expect(subject).to be_empty
      end
    end

    context 'with valid params' do
      let!(:my_user) { create(:user) }
      let!(:bookmark) { create(:bookmark, user: my_user) }
      let(:user_id) { my_user.id }

      it { is_expected.to_not be_empty }
      it { expect(subject.count).to eq 1 }
    end
  end

  describe '#is_bookmark?' do
    subject { service.is_bookmark?(city_name, user_id) }

    context 'with city_name param is nil' do
      let(:city_name) { nil }

      specify { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with user_id param is nil' do
      let(:user_id) { nil }

      specify { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when city is not bookmark' do
      it 'returns false' do
        expect(subject).to be_falsey
      end
    end

    context 'when city is bookmark' do
      let!(:my_user) { create(:user) }
      let!(:bookmark) { create(:bookmark, user: my_user) }
      let(:city_name) { bookmark.city_name }
      let(:user_id)   { my_user.id }

      it { expect(subject).to be_truthy }
    end
  end

  describe '#remove_from_bookmarks' do
    subject { service.remove_from_bookmarks(city_name, user_id) }

    context 'with city_name param is nil' do
      let(:city_name) { nil }

      specify { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with user_id param is nil' do
      let(:user_id) { nil }

      specify { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when city is bookmark' do
      let!(:my_user) { create(:user, id: user_id) }
      let!(:bookmark) { create(:bookmark, user: my_user, city_name: city_name) }

      it 'delete and return bookmark' do
        expect(subject).to eq(bookmark)
      end
    end

    context 'when city is not bookmark' do
      let!(:my_user) { create(:user, id: user_id) }

      it 'not found a bookmark and return nil' do
        expect(subject).to be_nil
      end
    end
  end
end

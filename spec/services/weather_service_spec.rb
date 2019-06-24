require 'rails_helper'

RSpec.describe WeatherService, type: :service do
  let(:service) { described_class.new }
  let(:city)    { 'Aruja' }

  describe '#get_weather' do
    subject { service.get_weather(city) }

    context 'with city param is nil' do
      let(:city) { nil }

      specify { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'with valid params' do
      it { is_expected.to be_an_instance_of Openweather2::Weather }
      its(:city) { is_expected.to eq city }
    end
  end
end

require 'rails_helper'

RSpec.describe WeatherHelper, type: :helper do

  describe '#fahrenheit_to_celsius' do
    subject { helper.fahrenheit_to_celsius(temperature) }

    context 'with temperature param is nil' do
      let(:temperature) { nil }

      it { is_expected.to eq('Erro ao obter a temperatura') }
    end

    context 'when temperature is 0' do
      let(:temperature) { 0 }

      it { is_expected.to eq(-18.0) }
    end

    context 'when temperature is 100' do
      let(:temperature) { 100 }

      it { is_expected.to eq(37.0) }
    end

    context 'when temperature is 32' do
      let(:temperature) { 32 }

      it { is_expected.to eq(0.0) }
    end

    context 'with invalid temperature param' do
      let(:temperature) { 'abc' }

      it { is_expected.to eq('Erro ao obter a temperatura') }
    end
  end
end

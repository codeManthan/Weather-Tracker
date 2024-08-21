require 'rails_helper'

RSpec.describe City, type: :model do
  let(:user) { create(:user) }
  let(:city) { create(:city, user: user) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:temperatures).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:lat) }
    it { should validate_presence_of(:lon) }

    it do
      should validate_numericality_of(:lat)
        .is_greater_than_or_equal_to(-90)
        .is_less_than_or_equal_to(90)
    end

    it do
      should validate_numericality_of(:lon)
        .is_greater_than_or_equal_to(-180)
        .is_less_than_or_equal_to(180)
    end
  end

  describe '#daily_temperatures' do
    let!(:today_temp) { create(:temperature, city: city, recorded_at: Time.zone.now, temperature: 20.5) }
    let!(:yesterday_temp1) { create(:temperature, city: city, recorded_at: 1.day.ago, temperature: 22.0) }
    let!(:yesterday_temp2) { create(:temperature, city: city, recorded_at: 1.day.ago + 2.hours, temperature: 24.0) }
    let!(:old_temp) { create(:temperature, city: city, recorded_at: 7.days.ago, temperature: 18.0) }

    it 'returns the correct daily temperatures for the last 7 days' do
      daily_temps = city.daily_temperatures

      expect(daily_temps.size).to eq(2) # Only today and yesterday should be included
      expect(daily_temps.first[:date]).to eq(1.day.ago.to_date)
      expect(daily_temps.first[:temperature]).to eq(23.0) # Average of 22.0 and 24.0
      expect(daily_temps.first[:recorded_at]).to eq(yesterday_temp2.recorded_at)

      expect(daily_temps.last[:date]).to eq(Time.zone.now.to_date)
      expect(daily_temps.last[:temperature]).to eq(20.5)
      expect(daily_temps.last[:recorded_at]).to eq(today_temp.recorded_at)
    end

    it 'excludes temperatures older than 7 days' do
      daily_temps = city.daily_temperatures

      expect(daily_temps.any? { |temp| temp[:date] == 7.days.ago.to_date }).to be_falsey
    end
  end
end

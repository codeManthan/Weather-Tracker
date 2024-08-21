class City < ApplicationRecord
  belongs_to :user
  has_many :temperatures, dependent: :destroy

  validates :name, presence: true
  validates :lon, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :lat, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }

  MAX_CITY_COUNT = 25

  # The data of temperature will be the last record of that day 
  # but the temperature will be the averager of that day
  def daily_temperatures
    temperatures
      .where('recorded_at >= ?', 6.days.ago.beginning_of_day)
      .group_by { |temp| temp.recorded_at.to_date }
      .map do |date, temps|
        {
          date: date,
          temperature: (temps.sum(&:temperature) / temps.size).round(2),
          recorded_at: temps.max_by(&:recorded_at).recorded_at,
          icon: temps.max_by(&:recorded_at).icon,
          humidity: temps.max_by(&:recorded_at).humidity,
          wind_speed: temps.max_by(&:recorded_at).wind_speed,
          mainline: temps.max_by(&:recorded_at).mainline,
          description: temps.max_by(&:recorded_at).description
        }
      end
      .sort_by { |entry| entry[:date] }
  end
end

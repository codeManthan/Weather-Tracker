class Temperature < ApplicationRecord
  belongs_to :city

  broadcasts_to :city, updates: :replace

  validates :temperature, presence: true, numericality: { greater_than: 0 }
  validates :recorded_at, presence: true

  def broadcast_update
    Rails.logger.info "Broadcasting update for city #{city.id} with temp_data: #{city.daily_temperatures.inspect}"
    Turbo::StreamsChannel.broadcast_update_to(
      city,
      target: "current_day_card",
      partial: "weather_reports/current_day_card",
      locals: { temp_data: secity.daily_temperatures }
    )
  end
end

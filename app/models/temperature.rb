class Temperature < ApplicationRecord
  belongs_to :city

  validates :temperature, presence: true, numericality: { greater_than: 0 }
  validates :recorded_at, presence: true

end

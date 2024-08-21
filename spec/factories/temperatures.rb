FactoryBot.define do
  factory :temperature do
    temperature { 25.0 }
    recorded_at { Time.zone.now }
    icon { "01d" }
    humidity { 60.0 }
    wind_speed { 5.0 }
    mainline { "Clear" }
    description { "clear sky" }
    association :city
  end
end
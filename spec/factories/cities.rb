FactoryBot.define do
  factory :city do
    name { "Sample City" }
    lat { 18.5204 }
    lon { 73.8567 }
    association :user
  end
end
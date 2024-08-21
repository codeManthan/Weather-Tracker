require 'rails_helper'

RSpec.describe WeatherReportsController, type: :controller do
  let(:user) { create(:user) }
  let(:city) { create(:city, user: user) }

  before do
    sign_in user
  end

  describe 'GET #show' do
    context 'when city exists' do
      it 'assigns @city and @temp_data and renders the show template' do
        get :show, params: { city_id: city.id }
        expect(assigns(:city)).to eq(city)
        expect(assigns(:temp_data)).to eq(city.daily_temperatures)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new city and redirects to the index' do
        expect {
          post :create, params: { city: { name: 'New City', lon: 10.0, lat: 10.0 } }
        }.to change(City, :count).by(1)
        expect(response).to redirect_to(weather_reports_path)
        expect(flash[:notice]).to eq('City was successfully created.')
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new city and redirects to the index' do
        expect {
          post :create, params: { city: { name: '', lon: 10.0, lat: 10.0 } }
        }.to_not change(City, :count)
        expect(response).to redirect_to(weather_reports_path)
        expect(flash[:alert]).to eq('Failed to create city.')
      end
    end
  end

  describe 'Private methods' do
    describe '#can_create_cities?' do
      context 'when user has reached max city count' do
        before do
          allow_any_instance_of(WeatherReportsController).to receive(:can_create_cities?).and_return(true)
          25.times { create(:city, user: user) }
        end

        it 'redirects with an alert' do
          post :create, params: { city: { name: 'Another City', lon: 10.0, lat: 10.0 } }
          expect(response).to redirect_to(weather_reports_path)
        end
      end
    end
  end
end

class WeatherReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :can_create_cities?, only: [:create]
  before_action :delete_city, only: [:confirm_delete, :destroy]


  def index
    @cities = current_user.cities

    respond_to do |format|
      format.html # For the initial page load
      format.turbo_stream { render partial: "cities_table", locals: { cities: @cities } }
    end
  end

  def show
    begin
      @city = current_user.cities.find(params[:city_id])
      @temp_data = @city.daily_temperatures

      if @temp_data.empty?
        flash[:alert] = "No data available for this city yet"
        redirect_to weather_reports_path
      else
        # Prepare data for Chart.js
        @chart_labels = @temp_data.map { |temp| temp[:recorded_at].strftime('%b %d') }
        @chart_data = @temp_data.map { |temp| temp[:temperature] }
      end
    rescue ActiveRecord::RecordNotFound
      render file: 'public/404.html', status: :not_found
    end
  end

  def create
    city = current_user.cities.build(city_params)
    if city.save
      flash[:notice] = 'City was successfully created.'
    else
      flash[:alert] = 'Failed to create city.'
    end
    respond_to do |format|
      format.html { redirect_to weather_reports_path }
    end
  end

  private
  def can_create_cities?
    if current_user.cities.count >= City::MAX_CITY_COUNT
      redirect_to weather_reports_path, alert: "You cannot create more than #{City::MAX_CITY_COUNT} cities."
    end
  end

  def city_params
    params.require(:city).permit(:name, :lon, :lat)
  end
end

module WeatherReportsHelper
  def week_day(date)
    date = Time.parse(date) if date.class == String
    date.strftime('%A')
  end
end

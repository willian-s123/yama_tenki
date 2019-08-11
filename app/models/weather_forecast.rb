class WeatherForecast

  def initialize(mountain_name)
    @geocode = LocalSearch.new(mountain_name).search
    @lat = @geocode.first
    @lng = @geocode.last
    @api_key = ENV['DARKSKY_KEY']
  end

  def http_get
    uri = URI.parse(target_url)
    Net::HTTP.get(uri)
  end

  def weather_info
    data = JSON.parse(http_get)
    data['daily']['summary']
  end

  private

  def base_url
    "https://api.darksky.net/forecast/#{@api_key}/#{@lat},#{@lng}"
  end

  def target_url
    base_url + '?' + URI.encode_www_form(params)
  end

  def params
    {
      'lang' => 'ja',
      'units' => 'si',
      'exclude' => 'minutely,hourly,alerts,flags'
    }
  end
end

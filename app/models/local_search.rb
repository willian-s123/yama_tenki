class LocalSearch

  def initialize(name)
    @mountain_name = name
    @map_key = ENV['GOOGLE_MAP_KEY']
  end

  def http_get
    uri = URI.parse(target_url)
    Net::HTTP.get(uri)
  end

  def search
    data = JSON.parse(http_get)
    lat = data["results"][0]["geometry"]["location"]["lat"]
    lng = data["results"][0]["geometry"]["location"]["lng"]
    return [lat, lng]
  end

  private

  def base_url
    'https://maps.googleapis.com/maps/api/geocode/json'
  end

  def target_url
    base_url + '?' + URI.encode_www_form(params)
  end

  def params
    {
      'address' => @mountain_name,
      'key' => @map_key
    }
  end
end

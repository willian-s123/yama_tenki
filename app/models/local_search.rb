class LocalSearch

  def initialize(name)
    @mountain_name = name
    @app_id = ENV['YAHOO_APP_ID']
    @base_url = 'https://map.yahooapis.jp/geocode/V1/geoCoder'
  end

  def http_get
    uri = URI.parse(target_url)
    Net::HTTP.get(uri)
  end

  def search
    data = JSON.parse(http_get)
    return data['Feature'][0]['Geometry']['Coordinates']
  end

  private

  def target_url
    @base_url + '?' + URI.encode_www_form(params)
  end

  def params
    {
      'appid' => @app_id,
      'query' => @mountain_name,
      'results' => '1',
      'output' => 'json'
    }
  end
end

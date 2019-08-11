class LocalSearch

  def initialize(name)
    @mountain = name
    @app_id = ENV['YAHOO_APP_ID']
    @base_url = 'https://map.yahooapis.jp/geocode/V1/geoCoder'
  end

  def search
    json = open(target_url).read
    data = JSON.parse(json)
    return data['Feature'][0]['Geometry']['Coordinates']
  end

  private

  def target_url
    @base_url + '?' + URI.encode_www_form(params)
  end

  def params
    {
      'appid' => @app_id,
      'query' => @mountain,
      'results' => '1',
      'output' => 'json'
    }
  end
end

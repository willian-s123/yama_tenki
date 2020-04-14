class LineJson

  def initialize(mountain_name)
    @mountain_name = mountain_name
  end

  def raply_json
    {
      "type": "template",
      "altText": "this is a carousel template",
      "template": {
        "type": "carousel",
        "columns": result_columns,
        "imageAspectRatio": "rectangle",
        "imageSize": "cover"
      }
    }
  end

  private

  def target_weather_info_json
    WeatherForecast.new(@mountain_name).weather_info_json
  end

  def result_columns
    target_weather_info_json.map do |info|
      date = Time.at(info['time'])
      youbi = %w[日 月 火 水 木 金 土]
      {
        "thumbnailImageUrl": ActionController::Base.helpers.asset_url("#{info['icon']}.png"),
        "imageBackgroundColor": "#FFFFFF",
        "title": "#{date.month}月#{date.day}日(#{youbi[date.wday]})",
        "text": "最高低気温: #{info['temperatureHigh'].round}度、#{info['temperatureLow'].round}度\n詳細: #{info['summary']}",
        "actions": [
          {
            "type": "postback",
            "label": " ",
            "data": "action=add&itemid=111"
          }
        ]
      }
    end
  end
end

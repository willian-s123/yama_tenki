require 'line/bot'

class LineApi

  def initialize(request_body, signature)
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
    @request_body = request_body
    @signature = signature
  end

  def valid?
    return false if @client.nil? || @request_body.nil? || @signature.nil?
    @client.validate_signature(@request_body, @signature)
  end

  def send
    events.each do |event|
      LineMessage.new(client: @client, message: event.message['text'], reply_token: event['replyToken']).reply
    end
  end

  private

  def events
    return [] if @client.nil? || @request_body.nil?
    @client.parse_events_from(@request_body)
  end
end

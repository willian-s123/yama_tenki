require 'line/bot'

class LineApi

  def initialize(line_chanel_secret, line_channel_token, request_body, signature)
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = line_chanel_secret
      config.channel_token = line_channel_token
    }
    @request_body = request_body
    @signature = signature
  end

  def events
    return [] if @client.nil? || @request_body.nil?
    @client.parse_events_from(@request_body)
  end

  def valid?
    return false if @client.nil? || @request_body.nil? || @signature.nil?
    @client.validate_signature(@request_body, @signature)
  end

  def send
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: 'text',
            text: event.message['text']
          }
        end
      end
      @client.reply_message(event['replyToken'], message)
    end
  end
end

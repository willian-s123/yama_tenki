class LineMessage

  PERMISSION_WARDS = ['山', '岳']

  def initialize(client:, message:, reply_token:)
    @client = client
    @message = message
    @reply_token = reply_token
  end

  def reply
    @client.reply_message(@reply_token, message_format)
  end

  private

  def message_format
    if valid?
      { type: 'text', text: @message }
    else
      { type: 'text', text: '山名を入力してください' }
    end
  end

  def valid?
    return false unless @message.is_a?(String)
    PERMISSION_WARDS.include?(last_word)
  end

  def last_word
    @message.last
  end
end

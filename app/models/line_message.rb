class LineMessage

  PERMISSION_WARDS = ['山', '岳']

  def initialize(client:, message:, reply_token:)
    @client = client
    @message = message
    @reply_token = reply_token
  end

  def reply
    @client.reply_message(@reply_token, make_reply_message)
  end

  private

  def make_reply_message
    if valid?
      LineJson.new(@message).raply_json
    else
      { type: 'text', text: '山名を入力してください' }
    end
  end

  def valid?
    last_word.is_a?(String) && PERMISSION_WARDS.include?(last_word)
  end

  def last_word
    if @message.present?
      @message.last
    else
      ''
    end
  end
end

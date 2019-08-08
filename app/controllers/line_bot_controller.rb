class LineBotController < ApplicationController

  def callback
    set_line_api
    if @line_api.valid?
      @line_api.send
      head :ok
    else
      render status: 400
    end
  end

  private

  def set_line_api
    request_body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    @line_api = LineApi.new(ENV["LINE_CHANNEL_SECRET"], ENV["LINE_CHANNEL_TOKEN"], request_body, signature)
  end
end

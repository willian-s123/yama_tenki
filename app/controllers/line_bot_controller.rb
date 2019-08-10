class LineBotController < ApplicationController

  def callback
    set_line_api
    if @line_api.valid?
      @line_api.send
      head :ok
    else
      render status: :bad_request
    end
  end

  private

  def request_body
    request.body.read
  end

  def signature
    request.env['HTTP_X_LINE_SIGNATURE']
  end

  def set_line_api
    @line_api = LineApi.new(ENV["LINE_CHANNEL_SECRET"], ENV["LINE_CHANNEL_TOKEN"], request_body, signature)
  end
end

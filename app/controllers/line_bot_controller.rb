class LineBotController < ApplicationController

  rescue_from :StandardError, with: :application_error

  def callback
    @line_api = LineApi.new(request_body, signature)
    @line_api.send
    head :ok
  end

  private

  def request_body
    request.body.read
  end

  def signature
    request.env['HTTP_X_LINE_SIGNATURE']
  end

  def application_error
    render json: { error: { message: '何らかのエラーが発生しました' } }, status: :internal_server_error
  end
end

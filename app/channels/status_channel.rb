class StatusChannel < ApplicationCable::Channel
  def subscribed
    stream_from "status_#{params[:type]}"
  end
end

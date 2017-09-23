class StatusChannel < ApplicationCable::Channel
  def subscribed
    type = params[:type]

    stream_from "status_#{type}"

    if type.start_with? 'uplink'
      uplink_name = type.split('_').last

      status = UplinkStatus.
               where(uplink_name: uplink_name).
               order('updated_at DESC').
               first

      ActionCable.server.broadcast "status_#{type}", status
    end
  end
end

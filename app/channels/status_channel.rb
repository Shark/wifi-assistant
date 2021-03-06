class StatusChannel < ApplicationCable::Channel
  def subscribed
    type = params[:type]

    stream_from "status_#{type}"

    if type.start_with? 'uplink'
      uplink_name = type.split('_').last

      UplinkStatus.
      where(uplink_name: uplink_name).
      order('updated_at DESC').
      first&.
      broadcast
    elsif type == 'connection'
      ConnectionStatus.
      order('updated_at DESC').
      first&.
      broadcast
    elsif type == 'speed_test'
      SpeedTest.
      order('updated_at DESC').
      first&.
      broadcast
    elsif type == 'location'
      Location.
      order('updated_at DESC').
      first&.
      broadcast
    end
  end
end

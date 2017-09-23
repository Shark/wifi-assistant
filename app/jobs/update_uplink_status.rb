class UpdateUplinkStatus < ApplicationJob
  def perform(uplink_name)
    base_url = AppConfig.fetch(:uplinks).fetch(uplink_name).fetch(:url)
    api = Uplink::API.new(base_url)

    uplink_status = UplinkStatus.from_api(
      uplink_name: uplink_name,
      monitoring_status: api.monitoring_status,
      current_plmn: api.current_plmn,
      traffic_statistics: api.traffic_statistics
    )
    uplink_status.save!
    uplink_status.broadcast
  end
end

class UplinkStatus < ApplicationRecord
  validates :uplink_name, presence: true

  def self.from_api(uplink_name:, monitoring_status:, current_plmn:, traffic_statistics:)
    new(
      uplink_name: uplink_name,
      connection_status: monitoring_status.connection_status,
      signal_bars: monitoring_status.signal_icon,
      network_type: monitoring_status.network_type,
      network_name: current_plmn.full_name,
      current_connect_time: traffic_statistics.current_connect_time,
      current_upload_rate: traffic_statistics.current_upload_rate,
      current_download_rate: traffic_statistics.current_download_rate,
      total_upload: traffic_statistics.total_upload,
      total_download: traffic_statistics.total_download
    )
  end

  def broadcast
    ActionCable.server.broadcast "status_uplink_#{uplink_name}", self
  end
end

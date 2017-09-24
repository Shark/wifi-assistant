class UpdateConnectionStatus < ApplicationJob
  def perform
    api = ConnectionStatus::API.new
    current_ip = api.current_ip
    current_hostname = api.hostname_for_ip(current_ip)

    ConnectionStatus.create!(
      is_working: true,
      current_ip: current_ip,
      provider: api.provider_for_hostname(current_hostname)
    ).tap {|status| status.broadcast }
  rescue => e
    ConnectionStatus.create!(is_working: false).tap {|status| status.broadcast }
    raise e
  end
end

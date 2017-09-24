require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every(10.seconds, 'update_uplink_status') do
    AppConfig[:uplinks].keys.each do |uplink_name|
      UpdateUplinkStatus.perform_later uplink_name
    end
  end

  every(30.seconds, 'update_connection_status') do
    UpdateConnectionStatus.perform_later
  end
end

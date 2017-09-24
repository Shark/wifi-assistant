class SpeedTest < ApplicationRecord
  def broadcast
    ActionCable.server.broadcast "status_speed_test", self
  end
end

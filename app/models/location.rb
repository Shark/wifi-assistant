class Location < ApplicationRecord
  def broadcast
    ActionCable.server.broadcast "status_location", self
  end
end

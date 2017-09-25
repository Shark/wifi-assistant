class ConnectionStatus < ApplicationRecord
  validates :is_working, inclusion: { in: [true, false] }

  def broadcast
    ActionCable.server.broadcast "status_connection", self
  end
end

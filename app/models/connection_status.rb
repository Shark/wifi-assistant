class ConnectionStatus < ApplicationRecord
  validates :is_working, presence: true

  def broadcast
    ActionCable.server.broadcast "status_connection", self
  end
end

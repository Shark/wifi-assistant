module Uplink
  module Model
    class TrafficStatistics < Dry::Struct
      # all values in kB
      attribute :current_connect_time, Types::Strict::Int
      attribute :current_upload, Types::Strict::Int
      attribute :current_download, Types::Strict::Int
      attribute :current_download_rate, Types::Strict::Int
      attribute :current_upload_rate, Types::Strict::Int
      attribute :total_upload, Types::Strict::Int
      attribute :total_download, Types::Strict::Int
      attribute :total_connect_time, Types::Strict::Int
    end
  end
end

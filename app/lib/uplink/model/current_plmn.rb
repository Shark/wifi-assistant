module Uplink
  module Model
    class CurrentPlmn < Dry::Struct
      attribute :full_name, Types::Strict::String
      attribute :short_name, Types::Strict::String
    end
  end
end

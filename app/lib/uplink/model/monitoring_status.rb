module Uplink
  module Model
    class MonitoringStatus < Dry::Struct
      ConnectionStatuses = Types::Strict::String.enum(
        'connecting',
        'connected',
        'disconnecting',
        'disconnected'
      )
      attribute :connection_status, ConnectionStatuses
      attribute :signal_icon, Types::Strict::Int.constrained(gteq: 0, lteq: 5)

      NetworkTypes = Types::Strict::String.enum(*%w[no_service gsm gprs edge wcdma hsdpa
                                                    hsupa hspa tdscdma hspa_plus evdo_rev_0
                                                    evdo_rev_a evdo_rev_b 1xrtt umb 1xevdv
                                                    3xrtt hspa_plus_64qam hspa_plus_mimo
                                                    lte])
      attribute :network_type, NetworkTypes

      class << self
        def connection_status_from_number(n)
          case n
          when 900 then 'connecting'
          when 901 then 'connected'
          when 902 then 'disconnected'
          when 903 then 'disconnecting'
          end
        end

        def network_type_from_number(n)
          case n
          when 0 then 'no_service'
          when 1 then 'gsm'
          when 2 then 'gprs'
          when 3 then 'edge'
          when 4 then 'wcdma'
          when 5 then 'hsdpa'
          when 6 then 'hsupa'
          when 7 then 'hspa'
          when 8 then 'tdscdma'
          when 9 then 'hspa_plus'
          when 10 then 'evdo_rev_0'
          when 11 then 'evdo_rev_a'
          when 12 then 'evdo_rev_b'
          when 13 then '1xrtt'
          when 14 then 'umb'
          when 15 then '1xevdv'
          when 16 then '3xrtt'
          when 17 then 'hspa_plus_64qam'
          when 18 then 'hspa_plus_mimo'
          when 19 then 'lte'
          end
        end
      end
    end
  end
end

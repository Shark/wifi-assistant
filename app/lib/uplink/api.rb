require 'uri'

module Uplink
  class API
    include HTTParty

    format :xml

    def initialize(base_uri)
      @base_uri = URI(base_uri)
    end

    def monitoring_status
      uri = base_uri.dup.tap do |uri|
        uri.path = '/api/monitoring/status'
      end

      put_session_id
      response = self.class.get(uri).parsed_response['response']
      Model::MonitoringStatus.new(
        connection_status: Model::MonitoringStatus.connection_status_from_number(Integer(response['ConnectionStatus'])),
        signal_icon: Integer(response['SignalIcon']),
        network_type: Model::MonitoringStatus.network_type_from_number(Integer(response['CurrentNetworkType']))
      )
    end

    def traffic_statistics
      uri = base_uri.dup.tap do |uri|
        uri.path = '/api/monitoring/traffic-statistics'
      end

      put_session_id
      response = self.class.get(uri).parsed_response['response']
      Model::TrafficStatistics.new(
        current_connect_time: Integer(response['CurrentConnectTime']),
        current_upload: Integer(response['CurrentUpload']),
        current_download: Integer(response['CurrentDownload']),
        current_download_rate: Integer(response['CurrentDownloadRate']),
        current_upload_rate: Integer(response['CurrentUploadRate']),
        total_upload: Integer(response['TotalUpload']),
        total_download: Integer(response['TotalDownload']),
        total_connect_time: Integer(response['TotalConnectTime'])
      )
    end

    def current_plmn
      uri = base_uri.dup.tap do |uri|
        uri.path = '/api/net/current-plmn'
      end

      put_session_id
      response = self.class.get(uri).parsed_response['response']
      Model::CurrentPlmn.new(
        full_name: response['FullName'],
        short_name: response['ShortName']
      )
    end

    private

    def put_session_id
      return if self.class.cookies['SessionID']

      uri = base_uri.dup.tap do |uri|
        uri.path = '/html/home.html'
      end

      session_id = self.class.get(uri).headers['set-cookie'].match(/SessionID=([^;]+)/)[1]
      self.class.cookies['SessionID'] = session_id
    end

    attr_reader :base_uri
  end
end

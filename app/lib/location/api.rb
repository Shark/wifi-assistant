class Location < ApplicationRecord
  class API
    def current
      wpt = document.css('gpx wpt')

      {
        lat: Float(wpt.attr('lat').value),
        lon: Float(wpt.attr('lon').value)
      }
    end

    private

    def document
      Nokogiri.parse gpsbabel_xml
    end

    def gpsbabel_xml
      call('gpsbabel -i garmin,get_posn -f usb: -o gpx -F -')
    end

    def call(cmd)
      `#{cmd}`.tap do
        if (status = $?.exitstatus) != 0
          raise "#{cmd} exited with status #{status}"
        end
      end
    end
  end
end

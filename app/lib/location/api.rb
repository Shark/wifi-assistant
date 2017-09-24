class Location
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
      #call('gpsbabel -i garmin,get_posn -f usb: -o gpx -F -')
      <<EOF
      <?xml version="1.0" encoding="UTF-8"?>
      <gpx version="1.0" creator="GPSBabel - http://www.gpsbabel.org" xmlns="http://www.topografix.com/GPX/1/0">
        <time>2017-09-24T10:01:56.546Z</time>
        <bounds minlat="51.961646592" minlon="7.631445983" maxlat="51.961646592" maxlon="7.631445983"/>
        <wpt lat="51.961646592" lon="7.631445983">
          <time>2017-09-24T09:01:56Z</time>
          <name>Position</name>
          <cmt>Position</cmt>
          <desc>Position</desc>
        </wpt>
      </gpx>
EOF
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

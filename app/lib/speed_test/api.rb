class SpeedTest < ApplicationRecord
  class API
    def run
      Speedtest::Test.new.run
    end
  end
end

class UpdateSpeedTest < ApplicationJob
  def perform
    result = SpeedTest::API.new.run

    SpeedTest.create!(
      download_rate: result.download_rate,
      upload_rate: result.upload_rate,
      latency: result.latency
    ).tap {|speed_test| speed_test.broadcast }
  end
end

class UpdateLocation < ApplicationJob
  def perform
    location = Location::API.new.current

    Location.create!(
      lat: location.fetch(:lat),
      lon: location.fetch(:lon)
    ).tap {|location| location.broadcast }
  end
end

class Api::MeterReadsController < ApplicationController


  def index
    meter_reads = 20.times.map do |increment|
      lat = 35.7 + (increment / 100.0) * rand(1..5)
      lon = -78.5 + (increment / 100.0) * rand(1..5)
      { id: increment, lat: lat, lon: lon, consumption: increment, date: Time.now }
    end
    render json: meter_reads
  end

end

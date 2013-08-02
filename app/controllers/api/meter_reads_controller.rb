class Api::MeterReadsController < ApplicationController

  def index
    render json: MeterRead.recent
  end

  def create
    meter_read = MeterRead.new meter_read_params
    if meter_read.save
      render nothing: true, status: 204
    else
      render json: meter_read.errors.full_messages, status: 422
    end
  end

  private

  def meter_read_params
    params.require(:meter_read).permit(:lat, :lon, :consumption)
  end
end

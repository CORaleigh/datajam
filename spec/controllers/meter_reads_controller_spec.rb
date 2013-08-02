require 'spec_helper'

describe Api::MeterReadsController do

  describe "GET index" do

    it "pulls meter reads from db" do
      meter_read = MeterRead.create(lat: 35.5, lon: -78.5, consumption: 3)
      get :index

      response.body.should eq [meter_read].to_json
    end

  end

  describe "POST create" do

    it "correctly creates a meter_read" do
      expect {
        post :create, meter_read: { lat: 35.5, lon: -78.5, consumption: 3 }
        response.status.should eq 204
      }.to change(MeterRead, :count).by(1)

      meter_read = MeterRead.last
      meter_read.lat == 35.5
      meter_read.lon == -78.5
      meter_read.consumption == 3
    end

    it "handles required fields" do
      expect {
        post :create, meter_read: { lat: 35.5, lon: -78.5 }
        response.status.should eq 422
      }.to change(MeterRead, :count).by(0)

      json_body = JSON.parse(response.body)
      json_body.should eq(["Consumption can't be blank"])
    end
  end
end

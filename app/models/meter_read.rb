class MeterRead < ActiveRecord::Base

  validates_presence_of :lat, :lon, :consumption

  scope :recent, -> { order(created_at: :desc).limit(20) }

end

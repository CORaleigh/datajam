class MeterRead < ActiveRecord::Base

  validates_presence_of :lat, :lon, :consumption

  scope :recent, -> { limit(20) }

end

task generate_sample1: :environment do
  while true do
    meter_read = MeterRead.create(lat: 37.78, lon: -122.41, consumption: rand(0..9))
    puts "Created MeterRead: { consumption: #{meter_read.consumption} }"
    sleep 2
  end
end

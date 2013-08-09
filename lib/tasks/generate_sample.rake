task generate_sample: :environment do
  while true do
    meter_read = MeterRead.create(lat: 35.64, lon: -78.51, consumption: rand(0..9))
    puts "Created MeterRead: { consumption: #{meter_read.consumption} }"
    sleep 1
  end
end

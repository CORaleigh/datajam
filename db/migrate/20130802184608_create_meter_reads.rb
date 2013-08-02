class CreateMeterReads < ActiveRecord::Migration
  def change
    create_table :meter_reads do |t|
      t.decimal :lat
      t.decimal :lon
      t.integer :consumption

      t.timestamps
    end
  end
end

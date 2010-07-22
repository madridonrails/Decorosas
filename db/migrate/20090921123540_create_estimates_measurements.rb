class CreateEstimatesMeasurements < ActiveRecord::Migration
  def self.up
    create_table :estimates_measurements, :id => false do |t|
      t.integer :estimate_id
      t.integer :measurement_id
    end
  end

  def self.down
    drop table :estimates_measurements
  end
end

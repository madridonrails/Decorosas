class CreateMeasurements < ActiveRecord::Migration
  def self.up
    create_table :measurements do |t|
      t.integer :project_id
      t.text :description
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :measurements
  end
end

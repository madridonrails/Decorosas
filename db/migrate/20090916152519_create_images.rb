class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.integer :measurement_id
      t.string :data_file_name
      t.string :data_content_type
      t.string :data_file_size
      t.datetime :data_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end

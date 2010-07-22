class CreateEstimates < ActiveRecord::Migration
  def self.up
    create_table :estimates do |t|
      t.integer :project_id
      t.text :description
      t.float :price
      t.text :notes
      t.timestamps
    end
  end

  def self.down
    drop_table :estimates
  end
end

class CreateElements < ActiveRecord::Migration
  def self.up
    create_table :elements do |t|
      t.integer :project_id
      t.text :description
      t.float :cost_price
      t.integer :units
      t.float :assembly_price

      t.timestamps
    end
  end

  def self.down
    drop_table :elements
  end
end

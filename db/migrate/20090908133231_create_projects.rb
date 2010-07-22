class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.integer :client_id
      t.integer :shop_id
      t.text :address
      t.string :code
      t.integer :accepted_estimate_id
      t.string :accepted_estimate_date
      t.text :notes
      t.string :state
      t.timestamps
    end

    #add_index :projects, :code, :unique => true
  end

  def self.down
    drop_table :projects
  end
end

class CreateFixes < ActiveRecord::Migration
  def self.up
    create_table :fixes do |t|

      t.text :description
      t.integer :project_id
      t.timestamps
    end
  end

  def self.down
    drop_table :fixes
  end
end

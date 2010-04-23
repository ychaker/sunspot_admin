class CreateSearchableItems < ActiveRecord::Migration
  def self.up
    create_table :searchable_items do |t|
      t.string :model
      t.string :field
      t.string :field_type
      t.integer :status

      t.timestamps
    end
  end

  def self.down
    drop_table :searchable_items
  end
end

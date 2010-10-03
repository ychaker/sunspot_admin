class CreateSearchableItems < ActiveRecord::Migration
  def self.up
    create_table :searchable_items do |t|
      t.string :searchable_model
      t.string :searchable_field
      t.string :searchable_field_type
      t.integer :searchable_status

      t.timestamps
    end
  end

  def self.down
    drop_table :searchable_items
  end
end

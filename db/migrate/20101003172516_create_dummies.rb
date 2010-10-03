class CreateDummies < ActiveRecord::Migration
  def self.up
    create_table :dummies do |t|
      t.string :name
      t.text :description
      t.integer :age
      t.datetime :date

      t.timestamps
    end
  end

  def self.down
    drop_table :dummies
  end
end

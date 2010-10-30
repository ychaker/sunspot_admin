class CreateDummies < ActiveRecord::Migration
  def self.up
    if RAILS_ENV == 'test'
      create_table :dummies do |t|
        t.string :name
        t.text :description
        t.integer :age
        t.datetime :date

        t.timestamps
      end
    end
  end

  def self.down
    if RAILS_ENV == 'test'
      drop_table :dummies
    end
  end
end

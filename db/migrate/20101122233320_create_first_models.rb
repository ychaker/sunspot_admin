class CreateFirstModels < ActiveRecord::Migration
  def self.up
    create_table :first_models do |t|
      t.string :name
      t.text :description
      t.integer :number

      t.timestamps
    end
  end

  def self.down
    drop_table :first_models
  end
end

class CreateExtraAttributesTable < ActiveRecord::Migration
  def self.up
    create_table :extra_attributes do |t|
      t.integer :model_id, :null => false
      t.string  :model_type, :null => false, :limit => 40
      t.string  :name, :null => false
      t.string  :value # make this a text field for larger values
      t.timestamps
    end
    add_index :extra_attributes, [:model_id, :model_type, :name], :unique => true
  end

  def self.down
    drop_table :extra_attributes
  end
end

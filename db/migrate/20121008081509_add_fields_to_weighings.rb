class AddFieldsToWeighings < ActiveRecord::Migration
  def self.up
    add_column :weighings, :abdominal_girth, :integer
    add_column :weighings, :adipose, :decimal, :precision => 3, :scale => 1
  end

  def self.down
    remove_column :weighings, :adipose
    remove_column :weighings, :abdominal_girth
  end
end

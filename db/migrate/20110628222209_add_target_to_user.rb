class AddTargetToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :target, :decimal, :precision => 4, :scale => 1
  end

  def self.down
    remove_column :users, :target
  end
end

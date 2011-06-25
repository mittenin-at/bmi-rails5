class AddHeightToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :height, :integer
  end

  def self.down
    remove_column :users, :height
  end
end

class AddPublicToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :public, :boolean
  end

  def self.down
    remove_column :users, :public
  end
end

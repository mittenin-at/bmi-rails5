class CreateWeighings < ActiveRecord::Migration
  def self.up
    create_table :weighings do |t|
      t.integer :user_id
      t.date :date
      t.decimal :weight, :precision => 4, :decimals => 3

      t.timestamps
    end
  end

  def self.down
    drop_table :weighings
  end
end

class AlterActivityTable < ActiveRecord::Migration
  def self.up
    add_column(:activities, :observations, :string, :null=>true)
  end

  def self.down
    remove_column(:activities, :observations)
  end
end

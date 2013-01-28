class AddPriority < ActiveRecord::Migration
  def self.up
      add_column(:services, :priority, :integer, :null=>true)
  end

  def self.down
      remove_column(:services, :priority)
  end
end

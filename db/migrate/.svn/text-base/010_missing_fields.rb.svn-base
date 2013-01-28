class MissingFields < ActiveRecord::Migration
  def self.up
    add_column :activities, :assistants_num, :integer, :null => true
  end

  def self.down
    remove_column :activities, :assistants_num
  end
end

class AddFieldsActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :participants, :string, :null => true
    add_column :activities, :institutions, :string, :null => true
  end

  def self.down
    remove_column :activities, :participants
    remove_column :activities, :institutions
  end
end

class AddProject < ActiveRecord::Migration
  def self.up
     add_column(:activities, :project_name, :string, :null=>true)
  end

  def self.down
     remove_column(:activities, :project_name)
  end
end

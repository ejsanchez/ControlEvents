class AlterSpaces < ActiveRecord::Migration
  def self.up
    add_column :spaces, :organization, :string, :null => true
  end

  def self.down
    remove_column :spaces, :organization
  end
end

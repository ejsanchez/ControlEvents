class ChangeStrings < ActiveRecord::Migration
  def self.up
      change_column :activities, :description, :text, :null=>false
      change_column :activities, :participants, :text, :null=>false
      change_column :activities, :institutions, :text, :null=>false
      change_column :reservations, :details, :text,  :null=>true
      change_column :services, :details, :text,  :null=>true
  end

  def self.down
      change_column :activities, :description, :string, :null=>false
      change_column :activities, :participants, :string, :null=>false
      change_column :activities, :institutions, :string, :null=>false
      change_column :reservations, :details, :string,  :null=>true
      change_column :services, :details, :string,  :null=>true
  end
end

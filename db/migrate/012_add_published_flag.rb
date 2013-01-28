class AddPublishedFlag < ActiveRecord::Migration
  class Activity < ActiveRecord::Base; end
  def self.up
    add_column :activities, :published, :boolean, :null => true, :default => false
    Activity.find(:all).map {|a| a.update_attribute(:published,false)}
  end

  def self.down
    remove_column :activities, :published
  end
end

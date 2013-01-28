class NumAssesAct < ActiveRecord::Migration
  class Activity < ActiveRecord::Base;end
  class OldActivity < ActiveRecord::Base;end
  def self.up
    add_column(:activities, :num_asses, :integer, :null=>true, :default=>0)
    add_column(:old_activities, :num_asses, :integer, :null=>true, :default=>0)
    Activity.find(:all).map {|a| a.update_attribute(:num_asses,1)}
    OldActivity.find(:all).map {|b| b.update_attribute(:num_asses,1)}
  end

  def self.down
    remove_column(:activities, :num_asses)
    remove_column(:old_activities, :num_asses)
  end
end

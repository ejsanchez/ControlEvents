class BeginDate < ActiveRecord::Migration
  class Activity < ActiveRecord::Base;end
  def self.up
      add_column(:activities, :begin_date, :date, :null=>true)
      add_column(:activities, :finish_date, :date, :null=>true)

      Activity.find(:all).map {|r|
       r.update_attribute(:begin_date,Activity.start_date(r.id).to_date)
       r.update_attribute(:finish_date,Activity.end_date(r.id).to_date)
    }

  end

  def self.down
      remove_column(:activities, :begin_date)
      remove_column(:activities, :finish_date)
  end
end

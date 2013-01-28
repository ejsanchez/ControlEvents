class AddManagerRole < ActiveRecord::Migration
  class Manager < ActiveRecord::Base;end

  def self.up
      add_column(:managers, :role, :integer, :null=>true, :default=>1)
      add_column(:activities, :assess_date, :date, :null=>true)

      Manager.find(:all).each do |r|       
       r.update_attribute(:role,1)
       r.save!
      end
  end

  def self.down
      remove_column(:managers, :role)
      remove_column(:activities, :assess_date)
  end
end

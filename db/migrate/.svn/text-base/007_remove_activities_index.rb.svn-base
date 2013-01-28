class RemoveActivitiesIndex < ActiveRecord::Migration
  def self.up
      remove_index(:reservations,'activity_id')
      add_index (:reservations, [:activity_id, :space_id, :start_date, :schedule, :status], :unique=>true, :name=>'reservations_defunique')
  end

  def self.down
      add_index (:reservations, [:activity_id, :space_id, :start_date, :schedule], :unique=>true)    
      remove_index(:reservations,'reservations_defunique')
  end
end

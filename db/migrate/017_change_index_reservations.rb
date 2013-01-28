class ChangeIndexReservations < ActiveRecord::Migration
  def self.up
    remove_index :reservations,	:name=>'reservations_defunique'
    add_index :reservations, [:activity_id, :space_id, :start_date, :start_time, :end_time, :status], :unique=>true, :name=>'by_activity_key'
  end

  def self.down
    add_index :reservations, [:activity_id, :space_id, :start_date, :schedule, :status], :unique=>true
    remove_index :reservations, :name=>'by_activity_key'
  end
end

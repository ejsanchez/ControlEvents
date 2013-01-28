class AlterReservationTable < ActiveRecord::Migration
  def self.up
    add_column(:reservations, :assistants_num, :integer, :null=>true)
    remove_column(:activities, :assistants_num)    
  end

  def self.down
    remove_column(:reservations, :assistants_num)
    add_column(:activities, :assistants_num, :integer, :null=>true)
  end
end

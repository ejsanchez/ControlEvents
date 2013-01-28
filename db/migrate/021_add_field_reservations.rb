class AddFieldReservations < ActiveRecord::Migration
  def self.up
    add_column(:reservations, :num_rapporteurs, :integer, :null=>true, :default=>0)
  end

  def self.down
    remove_column(:reservations, :num_rapporteurs)
  end
end

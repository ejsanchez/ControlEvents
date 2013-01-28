class DeleteTables < ActiveRecord::Migration
  class Reservation < ActiveRecord::Base;end
  class Activity < ActiveRecord::Base;end
  def self.up
    Reservation.find(:all).map {|a| a.destroy}
    Activity.find(:all).map {|a| a.destroy}

    if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
      execute "ALTER SEQUENCE activities_id_seq RESTART 1" 
      execute "ALTER SEQUENCE reservations_id_seq RESTART 1" 
    end
  end

  def self.down
  end
end

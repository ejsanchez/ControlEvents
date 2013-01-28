class CompleteTimes < ActiveRecord::Migration
  class Reservation < ActiveRecord::Base;end
  def self.up
    Reservation.find(:all).map {|r|  sch = r.schedule.split(/\s*\-\s*/)
       r.update_attribute(:start_time,sch[0])
       r.update_attribute(:end_time,sch[1])
    }
  end

  def self.down
    Reservation.find(:all).map {|a| a.update_attribute(:start_time,nil)
                                 a.update_attribute(:end_time,nil)}
  end
end

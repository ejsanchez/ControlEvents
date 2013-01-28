class BakupTables < ActiveRecord::Migration
  class Reservation < ActiveRecord::Base;end
  class OldReservation < ActiveRecord::Base;end
  class Activity < ActiveRecord::Base;end
  class OldActivity < ActiveRecord::Base;end

  def self.up
    Reservation.find(:all).each do |r|
        o=OldReservation.new(r.attributes)
        o.id = r.id
        o.save!
    end

    Activity.find(:all).each do |a|
        c=OldActivity.new(a.attributes)
        c.id = a.id
        c.save!
    end

  end

  def self.down
  end
end

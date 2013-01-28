class Request < ActiveRecord::Base

   belongs_to :service
   belongs_to :reservation

   def self.for_service(service)
       item = self.new
       item.reservation = reservation.id
       item
   end
end

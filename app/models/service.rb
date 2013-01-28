class Service < ActiveRecord::Base

   belongs_to :servicetype

   validates_presence_of(:name, :message => 'Indique el nombre del servicio.')
   validates_presence_of(:servicetype_id, :message => 'Indique el tipo de servicio.')

   def self.adm_services
       find(:all, :conditions => 'servicetype_id = 1')
   end

   def self.tec_services
       find(:all, :conditions => 'servicetype_id = 2')
   end

   def self.dif_services
       find(:all, :conditions => 'servicetype_id = 3')
   end

end

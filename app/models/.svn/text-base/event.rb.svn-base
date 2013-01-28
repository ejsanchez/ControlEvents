class Event < ActiveRecord::Base
   require_dependency 'date_validator'
   has_many :reservations
   has_many :spaces, :through=>:reservations
   belongs_to :eventype

   validates_presence_of :name,:description,:start_date,:end_date,
   :reservations_num,:assistants_num, :eventype_id

   validates_numericality_of :reservations_num, :assistants_num   
   validates_associated :eventype

   validates_dates :start_date, :from => Date.today, :allow_nil => false
   validates_dates :end_date, :from => Date.today, :allow_nil => false
   validate :dates_valid?

   def self.active_events
       find(:all,
            :conditions => "start_date > now()",
            :order      => "start_date")
   end

   protected
   def dates_valid?
     errors.add(:start_date, 'Debe especificar la fecha de inicio') if start_date.nil?
     errors.add(:end_date, 'Debe especificar la fecha de inicio') if end_date.nil?
     if start_date and end_date and start_date > end_date
       errors.add(:end_date, 'La fecha de fin debe ser mayor o  igual a la ' <<
                  'fecha de inicio')
     end
   end
end

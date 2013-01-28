class Activity < ActiveRecord::Base
   require_dependency 'date_validator'

   has_many :reservations
   has_many :spaces, :through=>:reservations
   belongs_to :activity_type

   validates_associated :activity_type

   validates_presence_of(:name, :message => 'Indique el nombre de la actividad')
   validates_uniqueness_of(:name, :message => 'Ya existe una actividad registrada con este nombre, debe modificarlo. Si se trata de la misma actividad pero diferente sesión, agregue un detalle al nombre, para diferenciarlo.')

   validates_presence_of(:description,:message => 'Indique la descripción de la actividad')
   validates_presence_of(:participants,:message => 'Indique los nombre de los participantes en la actividad')
   validates_presence_of(:person_reg, :message => 'Indique quien registra la actividad')
   validates_presence_of(:person_responsable, :message => 'Indique el responsable de la actividad')
   validates_presence_of(:email_contact, :message => 'Indique el e-mail del responsable')
   validates_presence_of(:password, :message => 'Indique algún password para la actividad')
   validates_presence_of(:phone_contact, :message => 'Indique algún teléfono de contacto')
   validates_presence_of(:area_id, :message => 'Indique el área de adscripción')
   validates_confirmation_of(:password, :message => 'El password debe coincidir')


    def self.valid_change(id)
#      three_days = 2*(60*60*24)
      parameter = AdvanceDay.find(1).days
      three_days = (parameter-1)*(60*60*24)
      day = Activity.start_date(id)
      if day.to_time < Time.now() + three_days
        return false
      else
        return true
      end
    end 


   def self.space_asked(id)
       res=Reservation.find(:first,:conditions => ["activity_id = ?", id])
       if res != nil
          return res.space_id
       else
          return false
       end
   end

   def self.start_date(id)
       Reservation.find(:first, 
                     :conditions => ["activity_id = ? and status < 3", id],
                     :order => "start_date").start_date
   end

   def self.end_date(id)
       Reservation.find(:first, 
                     :conditions => ["activity_id = ? and status < 3", id],
                     :order => "start_date DESC").start_date
   end

   def self.st_status(status)
       case status 
         when 1
            st = "En revisión"
         when 2
            st = "Autorizada"
         when 3
            st = "Cancelada"
         else 
            st = "Indefinida"
       end
       return st
   end

   def self.active(id)
      today = Time.now.strftime("%Y-%m-%d")
      Reservation.find(:first,:conditions =>["activity_id = ? AND start_date >= ? ",id,today], :order => "start_date DESC")     
   end

   def self.reservations(id)
       Reservation.find(:all,
                         :conditions => ["activity_id = ?",id], :order => "start_date")
   end

   def self.act_reservations(id)
       Reservation.find(:all,
                         :conditions => ["activity_id = ? and status <> 3",id], :order => "start_date")
   end

   def self.num_reservations(id)
       num = Reservation.find(:all,
                         :conditions => ["activity_id = ? AND status <> 3",id], :order => "start_date")
       return num.size
   end

#Los valores del estatus se deben interpretar como 1=solicitado, 2=autorizado, 3=rechazado, 4=cancelado.
   def self.authorized
       find(:all,
            :conditions => "status = 2", :order=> "begin_date")
   end

   def self.unauthorized
       find(:all,
            :conditions => "status = 1", :order=> "begin_date")
   end

   def self.canceled
       find(:all,
            :conditions => "status = 3", :order=> "begin_date")
   end

   def self.expired
      acts=find(:all,:conditions => "status <> 3", :order=> "begin_date")
      today = Time.now.strftime("%Y-%m-%d")
      expired =[]
      for item in acts do
       last=Reservation.find(:first,:conditions =>["activity_id = ? AND status <> 3",item.id], :order => "start_date DESC")     
       if last.start_date <= today.to_date
          expired << item
       end
      end
      return expired
   end

   def before_create
       self.password = Activity.crypted(self.password)
       self.password_confirmation = Activity.crypted(self.password_confirmation)
   end

    OPEN_OPTS = [
      [ 'Público en general(abierto)','abierto' ],
      [ 'Sólo público invitado(cerrado)','cerrado' ]
    ].freeze

    REACH_OPTS = [
      [ 'Nacional','nacional' ],
      [ 'Internacional','internacional' ]
    ].freeze


   private

   def Activity.crypted(password)
       Digest::MD5.hexdigest(password)
   end
end

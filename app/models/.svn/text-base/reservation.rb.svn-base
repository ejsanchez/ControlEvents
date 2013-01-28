# -*- coding: utf-8 -*-
class Reservation < ActiveRecord::Base
    belongs_to :activity
    belongs_to :space

    validates_presence_of(:space_id, :message => 'Debe indicar en qué espacio planea esta sesión')
    validates_associated(:space, :message => 'Debe indicar en qué espacio planea esta sesión')
#    validates_associated :activity,:space
    validates_presence_of(:start_date, :message => 'Debe indicar la fecha de la sesión.')
#    validates_presence_of(:schedule, :message => 'Debe indicar el turno de la sesión.')
    validates_presence_of(:assistants_num, :message => 'Indique el número aproximado de asistentes a la sesión')
    validates_presence_of(:start_time, :end_time, :message=>'Los campos de hora de inicio y fin de la sesión son obligatorios.')
    validates_length_of(:details, :maximum=>250, :message=>'Detalles: El texto de este campo es muy grande, solo puede usar hasta 250 caracteres.')

#    validates_uniqueness_of :activity_id, :scope=>[:space_id, :start_date,:schedule,:status]
    validates_uniqueness_of :activity_id, :scope=>[:space_id, :start_date,:start_time,:end_time,:status]
    validates_numericality_of(:assistants_num, :message=>'El número de asistentes debe ser numérico')

    validate :date_less_than_today
    validate :valid_prior?
    validate :is_sunday?
    validate :valid_duration?
    validate :valid_intertime?
    validate :non_working_day
    validate :non_vacations
    validate :cupo

#    validate :exists_event_in_date? 
#    validate :bigger_schedule

    def valid_change
#      three_days = 4*(60*60*24)
      parameter = AdvanceDay.find(1).days
      three_days = (parameter-1)*(60*60*24)
      if start_date.to_time < Time.now() + three_days
       self.errors.add("Anticipacion","Las reservaciones se aceptan sólo con un mínimo de '#{parameter}' días de anticipación") 
      else
       return true
      end
    end 

    HOUR_OPTS = %w{09:00 09:30 10:00 10:30 11:00 11:30 12:00 12:30 13:00 13:30 14:00 14:30 15:00 15:30 16:00 16:30 17:00 17:30 18:00 18:30 19:00 19:30 20:00 21:00}.freeze

    protected

    def date_less_than_today
       self.errors.add("Fecha_Inicio","La fecha de inicio debe ser posterior al día de hoy.") if start_date.to_time <= Time.now()
## Esta es la forma de darle formato a la fecha   Time.now.strftime("%Y-%d-%m") 
    end

    def valid_prior?
      parameter = AdvanceDay.find(1).days
      @three_days = (parameter-1)*(60*60*24)
#       @three_days = 4*(60*60*24)
       self.errors.add("Anticipacion","Las reservaciones se aceptan sólo con un mínimo de '#{parameter}' días de anticipación") if start_date.to_time < Time.now() + @three_days
    end
    
    def is_sunday?
       self.errors.add("Fecha","Reservación inválida. La fecha elegida es domingo.") if start_date.to_time.strftime("%w") == "0"
    end

    def valid_duration?
        self.errors.add("Fecha","La hora de fin debe ser mayor a la de inicio.") if end_time <= start_time               
    end 

    def valid_intertime?
        self.errors.add("Fecha","Reservación inválida. El horario se empalma con una sesión registrada anteriormente en este espacio.") if compare_times
    end

    def compare_times
      @events_in_day = Reservation.find(:all,:conditions => ["space_id = ? AND start_date = ? AND status <> 3",space_id, start_date]) 
      if @events_in_day.find{|e| e.start_time <= start_time && e.end_time >= start_time}
         return true
      else
         if @events_in_day.find{|e| e.start_time <= end_time && e.end_time >= end_time}
           return true
         else
           if @events_in_day.find{|e| e.start_time > start_time && e.end_time < end_time}
             return true
           else 
             return false
           end
         end
      end
    end

    def eval_begin_end
        self.errors.add("Fecha","Reservación inválida. El periodo de 14 a 16 horas no puede ocuparse pues no hay personal de apoyo en este horario.") if start_time.strftime("%H:%M") == "14:00" or end_time.strftime("%H:%M") == "16:00"
    end

  def sessions_limit
        self.errors.add("Fecha","Reservación inválida. Esta sesión excede el número de sesiones que se pueden atender en esta fecha, elija otro día.") if sessions_limit_bis
    end 

    def sessions_limit_bis        
        @sem = ActivityType.find(:first,:conditions=>"name='Seminario'").id
        @sessions_in_day = Reservation.find(:all,:conditions => ["start_date = ? AND status <> 3 AND space_id < 5", start_date]) 
        res = false 
        if activity_id == nil
            if @sessions_in_day.size >= 4
             res = true
            else   
             for item in @sessions_in_day do
               act=Activity.find(item.activity_id)
               if act.activity_type_id == @sem 
                 res = true
               end
             end             
            end
        else
            if @sessions_in_day.size >= 4
             res = true
            else   
             for item in @sessions_in_day do
               act=Activity.find(item.activity_id)
               if act.activity_type_id == @sem and item.activity_id != activity_id
                 res = true
               end
             end             
            end
        end
        return res
    end
  
    def non_working_day
        self.errors.add("Fecha","Reservación inválida. La fecha es un día inhábil.") if non_working_day_bis
    end 

    def non_working_day_bis
        res = false
        @nw_days = Holiday.find(:first,:conditions=>["app_date = ? ",start_date])  
        if @nw_days
	   res = true
        end          
        return res
    end 

    def non_vacations
        self.errors.add("Fecha","Reservación inválida. La fecha coincide con vacaciones.") if non_vacations_bis
    end 

    def non_vacations_bis
        res = false
        @vacations= Holiday.find(:first,:conditions=>["app_date < ? and app_date_end >= ?",start_date,start_date],
                                 :order=>'app_date')
        if @vacations
           res = true
        end
    end
 
    def cupo
      if !space or assistants_num > space.max_people
        self.errors.add("Fecha","Reservación inválida. El número de asistentes es mayor al cupo de la sala solicitada.")
      end
    end


#            @actType = Activity.find(activity_id).activity_type_id 
#  and item.activity_id != activity_id

#  Este bloque de código obedece al esquema de validación por horario.
#
#    def exists_event_in_date? 
#        errors.add("","Reservación inválida. Ya existe un evento registrado para este horario en este espacio.") if event_with_same_beginning 
#    end
#    def event_with_same_beginning
#      Reservation.find(:first,:conditions => ["space_id = ? AND start_date = ? AND schedule = ? AND status <> 3",space_id, start_date, schedule]) 
#    end
    
#    def bigger_schedule
#       if schedule == "08:30 - 14:00"
#          errors.add("","Reservación inválida. Ya existe un evento registrado para este horario en este espacio.") if bigger_schedule_1
#       else
#          if schedule == "16:00 - 20:00"
#             errors.add("","Reservación inválida. Ya existe un evento registrado para este horario en este espacio.") if bigger_schedule_2
#          end
#       end
#    end

#    def bigger_schedule_1
#        Reservation.find(:first,:conditions => ["space_id = ? AND start_date = ? AND status <> 3 AND (schedule = '08:30 - 11:00' OR schedule = '11:30 - 14:00')",space_id,start_date])       
#    end

#    def bigger_schedule_2
#        Reservation.find(:first,:conditions => ["space_id = ? AND start_date = ? AND status <> 3 AND (schedule = '16:00 - 18:00' OR schedule = '18:30 - 20:00')",space_id,start_date])       
#    end
end

# -*- coding: utf-8 -*-
class RegistrationController < ApplicationController

  def index   
     @activities = Activity.paginate(:per_page => 5, :page => params[:page], :order => 'id')
     destroy_order
     @acts = Activity.all     
     @activities = []
     for activity in @acts do
        if Activity.active(activity.id)
           @activities << activity
        end
     end
     if @activities.size == 0
        flash[:message] = 'Por el momento no existen actividades que se puedan modificar, ya sea porque han sido canceladas o porque ya fueron realizadas.'
     end
  end

  def new_order   
    @context = 'new'
    @activity = Activity.new
    @reservation = Reservation.new
    @spaces = Space.all
  end

  def create_activity
      @spaces = Space.all
      @activity = Activity.new(params[:activity])
      @reservation = Reservation.new(params[:reservation])
      session[:strcap] = @activity.password
    begin 
     Activity.transaction do
      if @activity.valid?
         if @reservation.valid?
           @activity.save
           @reservation.activity_id = @activity.id
           if @reservation.start_time.strftime("%H:%M") >= "16:00"
              @reservation.schedule = "vespertino"
           end
           @reservation.save
           flash[:message] = 'Su solicitud ha sido registrada exitosamente.<br/>'
           @bd = Activity.start_date(@activity.id)
           @fd = Activity.end_date(@activity.id)
           @activity.update_attribute(:begin_date,@bd)
           @activity.update_attribute(:finish_date,@fd)
           redirect_to(:action=>'create_order', :controller=>'notifier', :id => @activity.id, :pconf => session[:strcap])           
         else           
           flash[:error] = 'Para continuar rellene correctamente la forma.<br/>' << @reservation.errors.full_messages.join('<br/>')
           render :action=>'new_order'
         end
      else
       flash[:error] = 'Para continuar rellene correctamente la forma.<br/>' << @activity.errors.full_messages.join('<br/>')
       render :action=>'new_order'
      end
     end
    end
  end

  def valid_days(reservation)
     @dip = ActivityType.find(:first,:conditions=>"name='Diplomado'").id
     @day = reservation.start_date.strftime("%w").to_i
     res = true
     if @order.newactivity[0].activity_type_id != @dip and
        @day >= 5 and
        reservation.space_id < 6
          res = false
     end
     return res
  end

  def get_reservations
    @spaces = Space.all
      @order = find_order
      if @order.newactivity.size > 0 
         @qty = @order.newreservation.size
      end
  end

  def add_reservation
     @spaces = Space.all
     @reservation = Reservation.new(params[:reservation])     
#    Busca la orden 
     @order = find_order
#     Esta linea replicaba el id del espacio solicitado en las reservaciones siguientes.
#     to_add.space_id = @order.space_asked[0]
     if @reservation.valid?
        included = false
#    se valida que no exista ya una reservacion con las mismas caracteristicas
        for item in  @order.newreservation
          if item != nil
            if item.space_id == @reservation.space_id and
               item.start_date == @reservation.start_date and 
#   esta linea se utiliza al validar por periodos de horario
#               item.schedule == to_add.schedule
               item.start_time == @reservation.start_time and
               item.end_time == @reservation.end_time
                 included = true
            end
          end         
        end
        if included
          flash[:notice] = 'Ya solicitó una sesión para esta fecha y horario, indique otra.<br/>'       
          render :action=>'get_reservations'
#        redirect_to :back
        else
#          if valid_days(@reservation) 
#    Asigna los valores a un objeto en la sesión
             @order.newreservation << @reservation
             redirect_to :action => 'display_order' 
#          else
#             flash[:error] = 'Reservación inválida. Las salas no están disponibles los días viernes y sábados salvo que sean para los diplomados del Instituto.<br/>'
#             render :action=>'get_reservations' 
#          end
        end
     else
        flash[:error] = 'Para continuar rellene correctamente la forma.<br/>'
        render :action=>'get_reservations'
#        redirect_to :back
     end
  end

  def delete
     @order = find_order
     @newreservations = @order.newreservation
     @del_id = params[:id].to_i
     if @newreservations.size > 1  
        @newreservations.delete_at(@del_id - 1)
        redirect_to :action => 'display_order' 
     else
       flash[:error] = 'Imposible quitar la sesión, la actividad debe tener por lo menos una sesión solicitada.<br/>'
       redirect_to :action => 'display_order'            
     end
  end

  def update
     @order = find_order
     @activity = @order.newactivity[0]
     @pass = @activity.password
     @upd_act  = Activity.new(params[:activity])
     @upd_act.password = @pass    
     @upd_act.password_confirmation = @pass    
     if @upd_act.valid?
       @order.newactivity.delete_at(0)
       if @order.newactivity.size == 0
          @order.newactivity << @upd_act
          redirect_to :action => 'display_order' 
       else 
          flash[:error] = 'Imposible actualizar los datos.<br/>'           
       end
     else
       flash[:error] = 'Para continuar rellene correctamente la forma.<br/>' << @upd_act.errors.full_messages.join('<br/>')
       redirect_to :back
     end
  end

  def update_session
     @order = find_order
     ses = (params[:id].to_i) - 1
     @reservation = @order.newreservation[ses]
     @upd_ses  = Reservation.new(params[:reservation])
     if @upd_ses.valid?
       @order.newreservation.delete_at(ses)
       @order.newreservation << @upd_ses
       redirect_to :action => 'display_order' 
     else
       flash[:error] = 'Para continuar rellene correctamente la forma.<br/>' << @upd_act.errors.full_messages.join('<br/>')
       redirect_to :back
     end
  end

  def change_order
     @order = find_order
     @activity = @order.newactivity[0]
  end

  def change_session
     @spaces = Space.all
     @order = find_order
     @ses = params[:id]
     @reservation = @order.newreservation[@ses.to_i-1]
  end


  def display_order
     @order = find_order
     @newactivity = @order.newactivity
     @newreservations = @order.newreservation.sort_by{|i| i.start_date}
     @services = Granting.find(:all, :conditions => ["activity_type_id = ?",@newactivity[0].activity_type_id])
#     @space = @order.space_asked
  end

  def destroy_order
     @order = find_order
     @order.empty!
  end

  def cancel_order
     destroy_order
     redirect_to_index('El proceso de reservación ha sido cancelado.')
  end

  def save_order
     @order = find_order       
     @activity = @order.newactivity
     @act = @activity[0]
     begin 
       Activity.transaction do
         if @act.save                                   
            save_reservations(@act.id)  
            flash[:message] = 'Su solicitud ha sido registrada exitosamente.<br/>'
            @bd = Activity.start_date(@act.id)
            @fd = Activity.end_date(@act.id)
            @act.begin_date = @bd
            @act.finish_date = @fd
            @act.save            
            redirect_to(:action=>'create_order', :controller=>'notifier', :id => @act.id, :pconf => session[:strcap])
#            redirect_to(:action=>'permit_access', :controller=>'activities', :id => @act.id, :pconf => session[:strcap], :context=>"registration")
         else  
            flash[:error] = 'Error al registrar la actividad.<br/>' << @act.errors.full_messages.join('<br/>')
            redirect_to(:action=>'index')
         end
       end
     end
  end

  def save_reservations(activity_id)
     @order = find_order
     @requests = @order.newreservation
     for item in @requests
         item.activity_id = activity_id
         if item.start_time.strftime("%H:%M") >= "16:00"
            item.schedule = "vespertino"
         end
         item.save
     end
  end

  private
  def find_order
      session[:order] ||= Order.new   
  end

end

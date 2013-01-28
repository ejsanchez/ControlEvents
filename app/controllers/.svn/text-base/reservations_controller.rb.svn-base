# -*- coding: utf-8 -*-
class ReservationsController < ApplicationController
	before_filter :admin_entry, :only => [:show, :list]

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def new
    @reservation = Reservation.new
    @spaces = Space.find(:all)
    @day = Time.now() + ( AdvanceDay.first(:order => 'id').days * (60*24*24))
#    @spaces = Space.all.collect {|s| [s.name, s.id]}
  end

  def create
    @reservation = Reservation.new(params[:reservation])
    @activity =  Activity.find(@reservation.activity_id)    
    if @reservation.start_time.strftime("%H:%M") >= "16:00"
       @reservation.schedule = "vespertino"
    end
#    if valid_days
     if @reservation.save
      @bd=Activity.start_date(@activity.id)
      @fd=Activity.end_date(@activity.id)
      if @activity.update_attribute(:status,1) and
         @activity.update_attribute(:begin_date,@bd) and
         @activity.update_attribute(:finish_date,@fd)
        @res = Activity.reservations(@activity.id)
        for item in @res do
           if item.status == 2
              item.update_attribute(:status,1)
           end
        end              
#        flash[:message] = 'La reservación ha sido registrada con éxito.<br/>'       
#        redirect_to(:action=>'show', :controller => 'activities', :id => @reservation.activity_id) 
        redirect_to(:action=>'notify_change', :controller => 'notifier', :id => @activity.id) 
      else 
        flash[:error] = 'La reservación no ha podido ser registrada con éxito.<br/>'       
        redirect_to(:action=>'show', :controller => 'activities', :id => @reservation.activity_id)          
      end
     else
      flash[:error] = 'No se pudo registrar la reservación.<br/>' << @reservation.errors.full_messages.join('<br/>')
      redirect_to(:action=>'new', :id => @reservation.activity_id) 
     end
#    else
#     flash[:error] = 'Reservación inválida. Las salas no están disponibles los días viernes y sábados salvo que sean para los diplomados del Instituto.<br/>'<< @reservation.errors.full_messages.join('<br/>')
#     redirect_to(:action=>'new', :id => @activity) 
#    end
  end

  def valid_days
     @dip = ActivityType.find(:first,:conditions=>"name='Diplomado'").id
     @day = @reservation.start_date.strftime("%w").to_i
     res = true
     if @activity.activity_type_id != @dip and
        @day >= 5 and
        @reservation.space_id < 6
        res = false
     end
     return res
  end


  def edit
    @spaces = Space.all
    @reservation = Reservation.find(params[:id])
    @activity = @reservation.activity_id
  end

  def update
    parameter = AdvanceDay.find(1).days
    @spaces = Space.all
    @reservation = Reservation.find(params[:id])
    @upreservation = Reservation.new(params[:reservation])
    @activity=Activity.find(@reservation.activity_id)
    if @reservation.valid_change == true
#    if Activity.valid_change(@activity.id) == true
     if @reservation.update_attribute(:assistants_num,@upreservation.assistants_num) and
        @reservation.update_attribute(:num_rapporteurs,@upreservation.num_rapporteurs) and
        @reservation.update_attribute(:details,@upreservation.details)  and
        @reservation.update_attribute(:applicant_ip,@upreservation.applicant_ip)
       flash[:message] = 'La reservación ha sido actualizada con éxito.'
       redirect_to :action => 'show', :id => @activity, :controller=>'activities',:id => @reservation.activity_id
     else
       flash[:error] = 'La reservación no ha podido ser actualizada con éxito.' << @reservation.errors.full_messages.join('<br/>')
       redirect_to :action => 'edit', :id => @reservation.id
     end
    else
      flash[:error] = "Las modificaciones se aceptan sólo con un mínimo de '#{parameter}' días de anticipación."
      redirect_to :action => 'show', :controller => 'activities', :id => @reservation.activity_id
    end
  end

  def destroy
    Reservation.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def cancel
    parameter = AdvanceDay.find(1).days
    @reservation = Reservation.find(params[:id])    
    @activity = Activity.find(@reservation.activity_id)
    @num_reservations = Activity.num_reservations(@activity.id)

    if @reservation.valid_change == true and 
#    if Activity.valid_change(@activity.id) == true and 
       @num_reservations > 1
      if @reservation.update_attribute(:status,3)         
        @bd=Activity.start_date(@activity.id)
        @fd=Activity.end_date(@activity.id)
        if @activity.update_attribute(:status,1) and
           @activity.update_attribute(:begin_date,@bd) and
           @activity.update_attribute(:finish_date,@fd)
          
           @res = Activity.act_reservations(@activity.id)
           for item in @res do
               item.update_attribute(:status,1)
           end              
           redirect_to(:action=>'notify_change', :controller => 'notifier', :id => @activity.id, :context=>'cancelses') 
        else
           flash[:error] = 'La sesión no ha podido ser cancelada.'
           redirect_to :action => 'show', :controller => 'activities', :id => @reservation.activity_id
        end
      else
        flash[:error] = 'La sesión no ha podido ser cancelada.'
        redirect_to :action => 'show', :controller => 'activities', :id => @reservation.activity_id
      end    
    else
      if @num_reservations <= 1 
        flash[:error] = "No se puede cancelar esta sesión, pues la actividad debe tener por lo menos una sesión solicitada, si lo que quiere es cancelar la actividad use el botón de la parte inferior Cancelar solicitud."
        redirect_to :action => 'show', :controller => 'activities', :id => @reservation.activity_id        
      else
        flash[:error] = "Las modificaciones se aceptan sólo con un mínimo de '#{parameter}' días de anticipación."
        redirect_to :action => 'show', :controller => 'activities', :id => @reservation.activity_id
      end
    end
  end 

  def actual_year
    @actualY = Time.now.strftime('%Y').to_i
  end 

end

# -*- coding: utf-8 -*-
class AuthorizeController < ApplicationController
	before_filter :allowing
  
  def index
    find_spaces
  end

  def show  
    @activities = Activity.paginate(:per_page => 10, :page => params[:page], :order => 'id')
    find_spaces
    
    if params[:context] == "unauthorized" || params[:context] == nil || params[:context] == ''
       @acts = Activity.unauthorized
       @title = "en revisión"       
    else
       if params[:context] == "authorized"
         @acts = Activity.authorized
         @title = "autorizadas"       
       else
         if params[:context] == "canceled"
            @acts = Activity.canceled
            @title = "canceladas"   
         else
            if params[:context] == "expired"
               @acts = Activity.expired
               @title = "expiradas" 
            end   
         end
       end
    end
    @activities = []
    for space in @spaces do
     for activity in @acts do
      if Activity.space_asked(activity.id) == space.id 
         if params[:context] == "expired" 
             @activities << activity
         else
             if Activity.active(activity.id)
               @activities << activity
             end
         end
      end
     end
    end
    if @activities.size <= 0
       if flash[:message]
          flash[:message]=flash[:message].to_s + '<br/>No hay ninguna solicitud sin autorizar por el momento.'
       else
          flash[:message]='No hay ninguna solicitud por el momento.'
       end
#       redirect_to(:action => 'index', :controler => 'authorize')
    end
  end

  def detail
     @activity=Activity.find(params[:id])
     @context = params[:context]
  end

  def preassess 
      parameter = AdvanceDay.find(1).days
      @activity = Activity.find(params[:id])  
  end

  def assess
   parameter = AdvanceDay.find(1).days
   @activity = Activity.find(params[:id])
   asses = @activity.num_asses + 1
   @res = Activity.act_reservations(@activity.id)
   if session[:admin] == nil
     if Activity.valid_change(@activity.id) == true 
       if @activity.update_attribute(:status,2) and 
          @activity.update_attribute(:num_asses,asses)
        for reservation in @res do
           reservation.update_attribute(:status,2)      
        end
        redirect_to(:action => 'notify_auth', :controller => 'notifier', :id=> @activity.id)
       else
        flash[:error] = 'La sesión no se pudo autorizar.'
        redirect_to(:action => 'show', :controler => 'authorize', :context=>"unauthorize")
       end     
     else
       flash[:error] = "Las modificaciones se aceptan sólo con un mínimo de '#{parameter}' días de anticipación."
       redirect_to(:action => 'show', :controller => 'authorize', :context => "unauthorized")
     end
   else
     if @activity.update_attribute(:status,2)
      for reservation in @res do
         reservation.update_attribute(:status,2)      
      end
      redirect_to(:action => 'notify_auth', :controller => 'notifier', :id=> @activity.id)
     else
      flash[:error] = 'La sesión no se pudo autorizar.'
      redirect_to(:action => 'show', :controler => 'authorize', :context=>"unauthorize")
     end     
   end
  end

  def assign
  end

  def change_pass
  end
 
  def app_change_pass
     infields=params[:manager]
     if infields[:new_passwd]== infields[:new_passwd2]
        @manager = Manager.find(session[:manager_id])
        @cur_pass = Manager.crypted(infields[:current_passwd])
        @new_pass = Manager.crypted(infields[:new_passwd]) 
        if @cur_pass == @manager.password
           if @manager.update_attribute(:password,@new_pass)
              flash[:message] = 'La contraseña ha sido modificada exitosamente.'
              redirect_to :back
           else
              flash[:error] = 'La contraseña no ha podido ser modificada.'
              redirect_to :back
           end
        else
           flash[:error] = 'La contraseña actual no es válida.'
           redirect_to :back           
        end
     else
        flash[:error] = 'La nueva contraseña no coincide.'
        redirect_to :back  
     end
  end
  
  def report     
  end
 
  def list_report
    @areas = Area.find(:all)
    @period = params[:report]
    @sessions = Reservation.find(:all,:conditions=>["status = 2 and start_date >= ? and start_date <= ?",@period[:begin_date].to_time,@period[:end_date].to_time], :order=>'activity_id,start_date')
#     @activities = Activity.find(:all,:conditions=>["status = 2 and start_date >= ? and begin_date <= ?",@period[:begin_date].to_time,@period[:end_date].to_time],:order=>'begin_date')


#     if @activities.size <= 0
     if @sessions.size <= 0
        flash[:notice] = 'No hay ninguna actividad registrada en este periodo.'
        redirect_to :back  
#     else
#       for item in @activities do
#           @res = Activity.act_reservations(item.id)
#       end
        
     end
  end

  private
  
  def find_spaces
    @spaces = Space.find_spaces(session[:manager_id])
    return @spaces
  end
end

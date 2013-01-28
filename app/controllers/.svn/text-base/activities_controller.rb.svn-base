# -*- coding: utf-8 -*-
class ActivitiesController < ApplicationController
         before_filter :verify_login, :only => [:show, :edit, :destroy]
         before_filter :verify_user, :only => [:pre_cancel]

  def index
      redirect_to :action => 'index', :controller => 'consult'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @activities = Activity.authorized.paginate(:per_page => 10, :page => params[:page], :order => 'id')
    @actypes  = Hash[*ActivityType.all.map {|at| [at.id, at]}.flatten]
  end

  def show
    @activity = Activity.find(params[:id])
    @reservations = Activity.reservations(params[:id])
    @space = Reservation.find(:first,:conditions=>["activity_id = ?",params[:id]]).space_id
    @services = Granting.find(:all, :conditions => ["activity_type_id = ?",@activity.activity_type_id])
  end

  def new    
    @context = 'new'
    @activity = Activity.new
    @reservation = Reservation.new
    @spaces = Space.all
  end

  def create
    @activity = Activity.new(params[:activity])
    if @activity.save
      flash[:message] = 'La actividad ha sido creada exitosamente.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @activity = Activity.find(params[:id])
  end

  def update
    parameter = AdvanceDay.find(1).days
    @activity = Activity.find(params[:id])
    if Activity.valid_change(@activity.id) == true 
      if @activity.update_attributes(params[:activity])
        flash[:message] = 'La actividad ha sido actualizada exitosamente.'
        redirect_to :action => 'show', :id => @activity
      else
        flash[:error] = 'Para continuar rellene correctamente la forma.<br/>' << @activity.errors.full_messages.join('<br/>')
        render :action => 'edit',:context=>'edit'
      end
    else
      flash[:error] = "Las modificaciones se aceptan sólo con un mínimo de '#{parameter}' días de anticipación."
        redirect_to :action => 'show', :controller => 'activities', :id => @activity.id
    end
  end

  def destroy
    Activity.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
   
  def login
  end

  def permit_access
    @act = Activity.find(params[:id])
    if params[:context] == "registration"
        inputpass = params[:pconf]
    else
        inputparam = params[:activity]
        inputpass = inputparam[:password]
    end
#    @pass = Activity.crypted(inputpass[:password])
    @pass = Activity.crypted(inputpass)
    if @act.password == @pass
       session[:activity_id] = @act.id
       redirect_to(:action => "show", :controller => "activities", :id => @act.id) 
       flash[:message] = flash[:message] << "Ahora puede agregar sus cambios." 
    else
       flash[:error] = "Contraseña inválida para esta actividad.<br/>"
       redirect_to(:action => "login", :controller => "activities", :id => @act.id)
       session[:activity_id] = nil
    end
  end

  def pre_cancel       
  end

  def cancel
   parameter = AdvanceDay.find(1).days
   @activity = Activity.find(params[:id])
   @reason_cancel = params[:reason]
   @res = Activity.reservations(@activity.id)
   @published = @activity.published
   if session[:admin] == nil
    if Activity.valid_change(@activity.id) == true
      if @activity.update_attribute(:status,3) and 
         @activity.update_attribute(:observations,@reason_cancel)
        for reservation in @res do
           reservation.update_attribute(:status,3)      
        end        
        if session[:manager_id] == nil 
           if @published == true
              redirect_to :action => 'notify_cancel_act', :controller => 'notifier', :id => @activity.id,:context=>"#{params[:context]}"       
           else
              flash[:message] = 'La solicitud ha sido cancelada exitosamente.'
              redirect_to :action => 'index', :controller => 'registration'
           end
        else           
           redirect_to :action => 'notify_cancel_act', :controller => 'notifier', :id => @activity.id,:context=>"#{params[:context]}"    
        end
      else
        flash[:error] = 'La sesión no se pudo cancelar.'
        redirect :action => 'show', :id => @activity.id
      end    
    else
      flash[:notice] = "Las modificaciones se aceptan sólo con un mínimo de '#{parameter}' días de anticipación."
      if session[:manager_id] == nil
        redirect_to :action => 'show', :controller => 'activities', :id => @activity.id
      else  
        redirect_to :action => 'show', :controller => 'authorize', :context=> "#{params[:context]}"
      end
    end
   else
      if @activity.update_attribute(:status,3) and 
         @activity.update_attribute(:observations,@reason_cancel)
        for reservation in @res do
           reservation.update_attribute(:status,3)      
        end        
        if session[:manager_id] == nil 
           if @published == true
              redirect_to :action => 'notify_cancel_act', :controller => 'notifier', :id => @activity.id,:context=>"#{params[:context]}"       
           else
              flash[:message] = 'La solicitud ha sido cancelada exitosamente.'
              redirect_to :action => 'index', :controller => 'registration'
           end
        else           
           redirect_to :action => 'notify_cancel_act', :controller => 'notifier', :id => @activity.id,:context=>"#{params[:context]}"    
        end
      else
        flash[:error] = 'La sesión no se pudo cancelar.'
        redirect :action => 'show', :id => @activity.id,:context=>"#{params[:context]}"
      end    
   end
  end 
  
  def exit
      session[:activity_id] = nil
      session[:strcap] = nil
      redirect_to(:action => "index", :controller => "registration")
  end

#  def verify_ownner
#    if session[:activity_id] == nil
#       flash[:notice] = "Debe indicar la contraseña de la actividad para ingresar."
#       redirect_to(:controller => "activities", :action => "login", :id=>"#{params[:id]}")
#    else
#      if session[:activity_id] != "#{params[:id]}"
#        flash[:notice] = "Debe indicar la contraseña de la actividad para ingresar 1."
#        redirect_to(:controller => "activities", :action => "login", :id=>"#{params[:id]}")
#        exit
#      end
#    end
#  end

  def politics
    @spaces = Space.find(:all,:order=>'manager_id')
#    @managers = Manager.find(:all, :conditions=> ["login <> 'admin'"],:order => 'last_name, maiden_name')
    @admin_id = Manager.find(:first, :conditions=> ["login = 'admin'"]).id
  end

  def catalog
    @grantings = Granting.paginate(:order => 'activity_type_id',:per_page => 20, :page => params[:page])
  end

end

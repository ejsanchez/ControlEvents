# -*- coding: utf-8 -*-
# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base

#   model :order
   helper :date
   before_filter :setup_flash
   before_filter :generate_menu

   private

   def allowing
     unless session[:manager_id]
     flash[:notice] = "Debe tener un usuario para ingresar al sistema"
     redirect_to(:controller => "login", :action => "login")
     end
   end
   
   def admin_entry 
     unless session[:admin]
     flash[:notice] = "Debe ser administrador para ingresar a esta sección"
     redirect_to(:controller => "login", :action => "login")
     end
   end

   def redirect_to_index(msg = nil)
     flash[:message] = msg if msg
     redirect_to(:action => 'index', :controller=>'consult')
   end

   def actual_year
     @actualY = Time.now.strftime('%Y').to_i
   end

   def verify_user
     unless session[:activity_id] 
       unless session[:manager_id]
         flash[:notice] = "Debe conocer la contraseña para modificar la actividad, o ser administrador."
         redirect_to(:controller => "activities", :action => "login", :id=>"#{params[:id]}")       
       end
     else
       verify_owner
     end
   end 

   def verify_login
      unless session[:activity_id]
       flash[:notice] = "Debe indicar la contraseña de la actividad para ingresar."
       redirect_to(:controller => "activities", :action => "login", :id=>"#{params[:id]}")
      else
        verify_owner
      end
   end

   def verify_owner
      id = params[:id]
      unless session[:activity_id] ==  id.to_i
       flash[:notice] = 'Debe conocer la contraseña de la actividad para ingresar.'
       session[:activity_id] = nil
       redirect_to(:controller => "registration", :action => "index")
      end
   end
   
   def generate_menu
     @menu = [ # { :name => 'Inicio', :link => [:activities, :index]},
               { 
                 :name => 'Programación de actividades',
                 :children => [{:name => 'Ver calendario',
                                :link => [ :consult,  :calendar ]}, 
                               {:name => 'Ver por sala',
                                :link => [ :consult, :space]}
                              ]},
               { :name => 'Reservaciones',
                 :children => [{:name => 'Políticas',
                                :link => [ :activities,  :politics]},
                               {:name => 'Catálogo de servicios',
                                :link => [ :activity_types, :catalog]},
                               {:name => 'Nueva solicitud',
                                :link => [ :registration,  :new_order]},
                               {:name => 'Modificar solicitud',
                                :link => [ :registration,  :index]}]
               }]

#     if ! session[:activity_id].nil?
#       @menu << {:name =>'Salir del sistema', :link => [:activities, :exit]}
#     end

     @menu << 
       {:name => 'Buzón de sugerencias', :link => [:notifier, :save_advice]} 
#     <<     {:name => 'Créditos', :link => [ :activities, :contact]}

     if session[:manager_id] 
       if session[:admin]
         @menu << {:name => 'Menú principal', :link => [:admin, :index]}
       end
       if session[:manager_id] != Manager.find(:first,
                                               :conditions=>['login = ?', 'admin']).id
         @menu << {:name => 'Menú principal', 
           :link => [:authorize, :index]}
       end
     end
   end

   # Nos aseguramos que siempre haya un flash disponible
   def setup_flash
     [:warning, :error, :notice, :message].each {|level| flash[level] ||= []}
   end
end

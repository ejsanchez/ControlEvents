class LoginController < ApplicationController
	before_filter :allowing, :except => [:login, :authorize]

  def login
    session[:manager_id] = nil
    session[:admin] = nil
    @user = Manager.new
  end

  def authorize 
    @user = Manager.new(params[:manager])
    @user.password = Manager.crypted(@user.password)
    user_exists = Manager.find(:first, 
                         :conditions => ["login = ? and password = ?", @user.login,@user.password])
    if user_exists
       if user_exists.login == "admin"
         session[:manager_id] = user_exists.id
         session[:admin] = user_exists.id
         redirect_to(:action => "index", :controller => "admin") 
         flash[:message] = "Bienvenido al sistema." 
       else 
         session[:manager_id] = user_exists.id
         redirect_to(:action => "index", :controller => "authorize") 
         flash[:message] = "Bienvenido al sistema." 
       end
    else
       flash[:error] = "Nombre de usuario o contraseña inválido."
       redirect_to(:action => "login", :controller => "login")
    end
  end

  def logout
    session[:manager_id] = nil
    session[:admin] = nil
    redirect_to_index('Sesión concluída exitosamente')
  end 
end

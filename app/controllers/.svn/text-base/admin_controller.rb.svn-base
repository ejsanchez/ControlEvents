class AdminController < ApplicationController
        before_filter :admin_entry

  def index     
  end

  def search_auth
      @activities = Activity.find(:all,:conditions=>"status = 2 AND published = false")
      if @activities.size == 0
        flash[:message] = 'Por el momento no hay nuevas autorizaciones, intente más tarde'       
        redirect_to :back   
      else
        for activity in @activities do
          activity.published = true 
          activity.save!
        end        
        flash[:message] = 'Las siguientes actividades han sido actualizadas.'       
#        for activity in @activities do
#          activity.update_attribute(:published,true) 
#        end
      end
  end

  def search_days
      @ap_year = Time.now.strftime("%Y").to_i
      @app_year = @ap_year.to_s    
      @ini_date = @app_year +'-'+ '01' +'-'+ '01'
      @nw_days = Holiday.find(:all,:conditions=>["app_date >= ?", @ini_date])
      if @nw_days.size == 0
        flash[:message] = 'Por el momento no hay días registrados para este año.'       
        redirect_to :back   
      else
        flash[:message] = 'Los siguientes días son inhábiles.'       
      end
  end
end

class HolidaysController < ApplicationController
      before_filter :admin_entry 


  def index
    @ap_year = Time.now.strftime("%Y").to_i
    @app_year = @ap_year.to_s    
    @act_year = @app_year +'-'+ '01' +'-'+ '01'
    @holidays = Holiday.find(:all,:conditions=>["app_date >= ?",@act_year],:order=>'app_date')
    if @holidays.size == 0
      flash[:notice] = 'No hay días inhábiles registrados para este año.'
      @ant_year = @ap_year - 1
      @ap_year  = @ant_year.to_s
      @app_year = @ap_year +'-'+ '01' +'-'+ '01'
    end

    redirect_to(:action => 'list',:app_year=>@ap_year)
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @ap_year = Time.now.strftime("%Y").to_i
    @act_year = @ap_year.to_s    
    if params[:app_year] != nil
      @app_year = params[:app_year] 
    else
      @app_year = @ap_year.to_s    
    end 
    @ini_date = @app_year +'-'+ '01' +'-'+ '01'
    @holidays = Holiday.find(:all,:conditions=>["app_date >= ?",@ini_date],:order=>'app_date')
  end

  def new
    @holiday = Holiday.new
  end

  def new_period
    @holiday = Holiday.new
  end 

  def create
    @holiday = Holiday.new(params[:holiday])
    if @holiday.save
      flash[:notice] = 'La fecha ha sido agregada exitosamente.'
      redirect_to :action => 'list'
    else
      render :action => 'index'
    end
  end

  def destroy
     Holiday.find(params[:id]).destroy
     render :action => 'index'
  end
end

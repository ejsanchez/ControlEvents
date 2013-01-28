class ConsultController < ApplicationController

  def index      
      space
      render :action=>'space'
  end

  def space 
     @spaces = Space.find(:all,:order => "name")
  end

  def calendar
  end

  def select_month
     @space = Space.find(params[:id])     
  end

  def search    
     @space = Space.find(params[:id])
     @y_beg = Time.now().strftime("%Y").to_s
     @m_beg = params[:month]
     @mend = params[:month].to_i + 1
     @m_end = @mend.to_s
     if @mend > 12
        @m_end = "01"
        @ybega = @y_beg.to_i + 1
        @y_bega = @ybega.to_s
     else
       if @mend < 10  
        @m_end = "0" + @mend.to_s 
       end         
        @y_bega = @y_beg
     end
     @beg = @y_beg + "-" + @m_beg + "-" + "01"
     @endd = @y_bega + "-" + @m_end + "-" + "01"
     @reservations = Reservation.find(:all,:conditions=>["space_id = ? AND status = 2 AND start_date >= ? AND start_date < ?",params[:id], @beg,@endd], :order=> "start_date, schedule,activity_id")
     if @reservations.size <= 0
        flash[:message] = "No hay ninguna actividad programada en este mes para este espacio."
        redirect_to :back
     end
  end

end

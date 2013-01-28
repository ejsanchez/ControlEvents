class GrantingsController < ApplicationController
	before_filter :admin_entry

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @grantings = Granting.paginate(:order => 'activity_type_id', 
                                   :per_page => 20, :page => params[:page])
  end

#  def show
#    @granting = Granting.find(params[:id])
#  end

  def new
    @granting = Granting.new
  end

  def create
    @granting = Granting.new(params[:granting])
    if @granting.save
      flash[:message] = 'El servicio ha sido otorgado satisfactoriamente.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

#  def edit
#    @granting = Granting.find(params[:id])
#  end

#  def update
#    @granting = Granting.find(params[:id])
#    if @granting.update_attributes(params[:granting])
#      flash[:notice] = 'Granting was successfully updated.'
#      redirect_to :action => 'show', :id => @granting
#    else
#      render :action => 'edit'
#    end
#  end

  def destroy
    Granting.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end

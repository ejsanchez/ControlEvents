class ActivityTypesController < ApplicationController
	before_filter :admin_entry, :except=>[:catalog,:grants]
  def index
    list
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @activity_types = ActivityType.paginate(:per_page => 10, :page => params[:page], :order => 'id')
  end

  def show
    @activity_type = ActivityType.find(params[:id])
  end

  def new
    @activity_type = ActivityType.new
  end

  def create
    @activity_type = ActivityType.new(params[:activity_type])
    if @activity_type.save
      flash[:message] = 'El tipo de actividad ha sido creado exitosamente.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @activity_type = ActivityType.find(params[:id])
  end

  def update
    @activity_type = ActivityType.find(params[:id])
    if @activity_type.update_attributes(params[:activity_type])
      flash[:message] = 'El tipo de actividad ha sido modificado exitosamente.'
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end

  def destroy
    ActivityType.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def grants
    render :text=> "Servicios para: <b>" +
                   "#{ActivityType.find(params[:id]).name}"+"</b><br/><ul>" + 
                   "#{ActivityType.grantings(params[:id])}" + "</ul>"
  end

  def catalog
     @actypes=ActivityType.find(:all,:order=>'name')
  end
end

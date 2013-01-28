class ManagersController < ApplicationController	
	before_filter :admin_entry
 
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @managers = Manager.paginate(:per_page => 10, :page => params[:page], :order => 'id')
  end

  def show
    @manager = Manager.find(params[:id])
  end

  def new
    @manager = Manager.new
  end

  def create
    @manager = Manager.new(params[:manager])
    if @manager.save
      flash[:message] = 'El usuario ha sido registrado exitosamente.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @manager = Manager.find(params[:id])
  end

  def update
    @manager = Manager.find(params[:id])
    if @manager.update_attributes(params[:manager])
      flash[:message] = 'Los datos del usuario han sido actualizados exitosamente.'
      redirect_to :action => 'list'
    else
      flash[:notice] = 'Los datos del usuario NO han podido ser actualizados.'<< @manager.errors.full_messages.join('<br/>')
      redirect_to :action => 'edit', :id=> @manager.id, :context=> 'edit'
    end
  end

  def destroy
    Manager.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end

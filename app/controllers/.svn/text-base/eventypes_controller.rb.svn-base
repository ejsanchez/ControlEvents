class EventypesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @eventypes = Eventype.paginate(:per_page => 10, :page => params[:page], :order => 'id')
  end

  def show
    @eventype = Eventype.find(params[:id])
  end

  def new
    @eventype = Eventype.new
  end

  def create
    @eventype = Eventype.new(params[:eventype])
    if @eventype.save
      flash[:notice] = 'Eventype was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @eventype = Eventype.find(params[:id])
  end

  def update
    @eventype = Eventype.find(params[:id])
    if @eventype.update_attributes(params[:eventype])
      flash[:notice] = 'Eventype was successfully updated.'
      redirect_to :action => 'show', :id => @eventype
    else
      render :action => 'edit'
    end
  end

  def destroy
    Eventype.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end

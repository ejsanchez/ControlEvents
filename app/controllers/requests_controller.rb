class RequestsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @requests = Request.paginate(:per_page => 10, :page => params[:page], :order => 'id')
  end

  def show
    @request = Request.find(params[:id])
  end

  def new
    @request = Request.new
    if params[:context] == :registration
       render(:layout => false)
    end
  end

  def create
    @request = Request.new(params[:request])
    if @request.save
      flash[:notice] = 'Request was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @request = Request.find(params[:id])
  end

  def update
    @request = Request.find(params[:id])
    if @request.update_attributes(params[:request])
      flash[:notice] = 'Request was successfully updated.'
      redirect_to :action => 'show', :id => @request
    else
      render :action => 'edit'
    end
  end

  def destroy
    Request.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end

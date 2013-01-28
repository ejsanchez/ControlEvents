# -*- coding: utf-8 -*-
class ServicesController < ApplicationController
	before_filter :admin_entry
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @services = Service.paginate(:per_page => 15, :page => params[:page], :order => 'priority')
  end

  def show
    @service = Service.find(params[:id])
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(params[:service])
    if @service.save
      flash[:message] = 'El servicio ha sido creado con éxito.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @service = Service.find(params[:id])
  end

  def update
    @service = Service.find(params[:id])
    if @service.update_attributes(params[:service])
      flash[:message] = 'El servicio ha sido actualizado con éxito.'
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end

  def destroy
    Service.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end

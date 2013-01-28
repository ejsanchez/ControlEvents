# -*- coding: utf-8 -*-
class AreasController < ApplicationController
      before_filter :admin_entry 

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @areas = Area.paginate(:per_page => 10, :page => params[:page], :order => 'id')
  end

  def show
    @area = Area.find(params[:id])
  end

  def new
    @area = Area.new
  end

  def create
    @area = Area.new(params[:area])
    if @area.save
      flash[:message] = 'La unidad o área fué creada con éxito.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @area = Area.find(params[:id])
  end

  def update
    @area = Area.find(params[:id])
    if @area.update_attributes(params[:area])
      flash[:message] = 'La unidad o área fué actualizada con éxito.'
      redirect_to :action => 'list'
    else
      render :action => 'list'
    end
  end

  def destroy
    if Area.find(params[:id]).destroy
      flash[:message] = 'La unidad o área fué eliminada con éxito.'
      redirect_to :action => 'list'
    else
      flash[:notice] = 'Error a borrar la unidad o área, intente más tarde.'
      redirect_to :action => 'list'
    end
  end
end

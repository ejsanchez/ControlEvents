# -*- coding: utf-8 -*-
class SuppliersController < ApplicationController
	before_filter :admin_entry

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @suppliers = Supplier.paginate(:per_page => 10, :page => params[:page], :order => 'id')
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(params[:supplier])
    if @supplier.save
      flash[:message] = 'El contacto ha sido agregado son éxito.'
      redirect_to :action => 'list'
    else
      flash[:notice] = 'El contacto NO ha podido agregarse con éxito.'
      redirect_to :action => 'new'
    end
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

  def update
    @supplier = Supplier.find(params[:id])
    if @supplier.update_attributes(params[:supplier])
      flash[:message] = 'El contacto ha sido actualizado exitosamente.'
      redirect_to :action => 'list'
    else
      flash[:notice] = 'El contacto NO ha podido actualizase con éxito.'
      redirect_to :action => 'edit', :id=> @supplier.id
    end
  end

  def destroy
    Supplier.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end

# -*- coding: utf-8 -*-
class SpacesController < ApplicationController
      before_filter :admin_entry

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @spaces = Spaces.paginate(:per_page => 10, :page => params[:page], :order => 'id')
  end

  def show
    @space = Space.find(params[:id])
  end

  def new
    @space = Space.new
  end

  def create
    @space = Space.new(params[:space])
    @assigment = Assigment.new(params[:assigment])
    @assigmt2 = Assigment.new(params[:assigment])
    if @space.save 
       @assigment.space_id = @space.id         
       @assigmt2.space_id = @space.id         
       @assigmt2.manager_id = 1   
       if @assigment.save and @assigmt2.save
          flash[:message] = 'El espacio ha sido registrado con éxito.'
          redirect_to :action => 'list'
       else
          flash[:message] = 'El espacio no pudo ser registrado.'
          render :action => 'new'
       end
    else
      flash[:message] = 'El espacio no ha sido registrado.'
      render :action => 'new'
    end
  end

  def edit
    @space = Space.find(params[:id])
  end

  def update
    @space = Space.find(params[:id])
    if @space.update_attributes(params[:space])
      flash[:message] = 'El espacio fué actualizado exitosamente.'
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end

  def destroy
    Space.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end

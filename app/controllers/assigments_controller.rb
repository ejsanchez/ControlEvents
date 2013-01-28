# -*- coding: utf-8 -*-
class AssigmentsController < ApplicationController
      before_filter :admin_entry 

  def index
    redirect_to :action=>'change'
  end

  def change
    @spaces = Space.paginate(:per_page => 10, :order=> 'name', :page => params[:page])
  end

  def edit
    @assigment = Assigment.find(:first, :conditions=>["space_id = ? and manager_id <> 1",params[:id]])    
  end  

  def update    
    @assigment = Assigment.find(params[:id])
    if @assigment.update_attributes(params[:assigment])
      flash[:message] = 'La asignación ha sido actualizada exitosamente.'
      redirect_to :action => 'change'
    else
      flash[:error] = 'La asignación no ha sido actualizada.'
      render :action => 'edit'
    end
  end
end

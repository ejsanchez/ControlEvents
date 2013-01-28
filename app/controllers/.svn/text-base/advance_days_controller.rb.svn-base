# -*- coding: utf-8 -*-
class AdvanceDaysController < ApplicationController
	before_filter :allowing
        before_filter :admin_entry, :only => [:new, :create, :destroy]

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @advance_days = AdvanceDay.paginate(:per_page => 10, :page => params[:page], :order => 'id')
  end

  def new
    @advance_day = AdvanceDay.new
  end

  def create
    @advance_day = AdvanceDay.new(params[:advance_day])
    if @advance_day.save
      flash[:message] = 'La regla ha sido modificada con éxito.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @advance_day = AdvanceDay.find(params[:id])
  end

  def update
    @advance_day = AdvanceDay.find(params[:id])
    if @advance_day.update_attributes(params[:advance_day])
      flash[:message] = 'La regla ha sido modificada con éxito.'
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end

  def destroy
    AdvanceDay.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end

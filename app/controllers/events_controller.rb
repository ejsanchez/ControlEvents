# -*- coding: utf-8 -*-

class EventsController < ApplicationController
  def index
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @aevents=Event.active_events
    @events = Event.paginate(:per_page => 10, :page => params[:page], :order => 'id')
  end
  
  def cancel
    @events = Event.paginate(:per_page => 10, :page => params[:page], :order => 'id')
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      flash[:notice] = 'El evento está registrado, complete la reservación'
      redirect_to :controller => 'reservations',:action => 'new', :id => @event.id
    else
      flash[:notice] = 'El evento no se pudo registrar, intente de nuevo.'
      render :action => 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      flash[:notice] = 'Event was successfully updated.'
      redirect_to :action => 'show', :id => @event
    else
      render :action => 'edit'
    end
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end

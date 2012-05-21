# -*- encoding : utf-8 -*-
class EventsController < ApplicationController

  def index
    begin
      @date=Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    rescue
      @date=Date.today
    end
    @events=Event.daily(@date).all
    @prev,@succ=@date-1.day,@date+1.day
  end

  def week
    begin
      @date=Date.strptime("#{params[:week]}.#{params[:year]}", "%W.%Y")
    rescue
      @date=Date.today.beginning_of_week
    end
    @events=Event.weekly(@date).all
    @prev,@succ=@date-1.day,@date+8.days
  end

  def month
    begin
      @date=Date.new(params[:year].to_i,params[:month].to_i,1)
    rescue
      @date=Date.today.beginning_of_month
    end
    @events=Event.monthly(@date).all
    @month=@date.month
    @prev,@succ=@date-1.day,@date+1.month
  end


  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new(:mode=>0)
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(params[:event])

    if @event.save
      redirect_to @event, notice: 'Событие создано.'
    else
      render 'new'
    end
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      redirect_to @event, notice: 'Событие сохранено.'
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path,:notice=>"Событие удалено"
  end
end

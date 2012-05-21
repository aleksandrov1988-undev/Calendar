# -*- encoding : utf-8 -*-
class Event < ActiveRecord::Base
  attr_accessible :mask, :mode, :name, :start_at
  MODE_TYPES=%w(Не\ повторять Еженедельно Ежемесячно)

  validates :name, :presence => true, :length => {:maximum => 255}
  validates :start_at, :presence => true
  validates :mode, :presence => true, :inclusion => {:in => 0...MODE_TYPES.size}
  validates :mask, :presence => true, :numericality => {:grater_than_or_equal_to => 0, :only_integer => true}


  validates_with EventValidator

  default_scope order("strftime('%H',start_at), strftime('%M',start_at)")
  scope :daily, ->(date) { where("start_at>= ? and start_at <? or (mode=1 and mask&?>0 or mode=2 and mask&?>0) and start_at<=?", date, date+1.day, 1<<(date.cwday-1), 1<<(date.day-1),date+1.day) }
  scope :weekly, ->(date) { where("start_at>= ? and start_at <? or (mode=1 and mask>0 or mode=2 and mask&?>0) and start_at<=?", date, date+1.week, Event.mask_token(date, 7),date+1.week) }
  scope :monthly, ->(date) { where("start_at>= ? and start_at <? or mask>0 and start_at<=?", date, date+1.month,date+1.month) }

  def weekly?
    mode==1
  end

  def monthly?
    mode==2
  end

  def repeat?
    mode>0
  end

  def at?(args={})
    if args[:wday].present?
      return weekly? && mask&(1<<args[:wday]-1)>0
    elsif args[:day].present?
      return monthly? && mask&(1<<(args[:day]-1))>0
    end
    false
  end

  def is?(date)
    self.start_at >=date && self.start_at <date+1.day
  end

  def today?(date)
    is?(date) || (at?(:wday => date.cwday) || at?(:day => date.day)) && self.start_at<=date
  end

  def human_mask
    return "" if !repeat? || self.mask.to_i==0
    m=self.mask
    days=[]
    i=0
    while m>0
      if m&1>0
        if weekly?
          days << I18n.t('date.abbr_day_names')[(i+1)%7]
        elsif monthly?
          days << i+1
        end
      end
      i+=1
      m>>=1
    end
    return "еженедельно по #{days.join(', ')}" if weekly?
    return "ежемесячно по #{days.join(', ')} числам"
  end

  def Event.mask_token(date, n)
    days=[]
    res=0
    n.times do
      days << date.day
      date+=1.day
    end
    days.each { |num| res+=1<<(num-1) }
    res
  end

end

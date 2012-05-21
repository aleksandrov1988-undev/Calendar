# -*- encoding : utf-8 -*-
module EventsHelper
  def mask_label(event,i)
    label1=i<7 ? t('date.abbr_day_names')[(i+1)%7] : nil
    label2=i+1
    classes=['btn','btn-mask']
    classes << 'active' if event.mask.to_i&(1<<i)>0
    content_tag :span, i+1,:class=>classes,'data-toggle'=>'button','data-value'=>2**i,"data-label1"=>label1,'data-label2'=>label2
  end

  def wday_badge(event,i)
    classes="label"
    classes << " label-info" if event.at?(:wday=>i)
    content_tag(:span,t('date.abbr_day_names')[i%7],:class=>classes)
  end

  def day_badge(event,i)
      classes="label"
      classes << " label-info" if event.at?(:day=>i)
      content_tag(:span,i,:class=>classes)
    end
end

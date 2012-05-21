# -*- encoding : utf-8 -*-
Event.create(:name=>"Событие 1",:start_at=>Time.now+2.weeks,:mask=>0,:mode=>0)
Event.create(:name=>"Еженедельное событие",:start_at=>Time.now+3.weeks,:mask=>0b1100000,:mode=>1)
Event.create(:name=>"Ежемесячное событие",:start_at=>Time.now+4.weeks,:mask=>124,:mode=>2)
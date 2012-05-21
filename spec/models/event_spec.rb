# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Event do
  before(:each) do
    @attr={:name => "Встреча", :mode => 0, :mask => 0, :start_at => Time.now+2.weeks}
  end

  it "should create a new instance given valid attributes" do
    Event.create!(@attr)
  end

  it "should require name" do
    event=Event.new(@attr.merge(:name => ''))
    event.should_not be_valid
  end

  it "should require name less than 255 symbols" do
    event=Event.new(@attr.merge(:name => 'a'*300))
    event.should_not be_valid
  end

  it "should require start_at" do
    event=Event.new(@attr.merge(:start_at => nil))
    event.should_not be_valid
  end

  it "should require mode" do
    event=Event.new(@attr.merge(:mode => nil))
    event.should_not be_valid
  end

  it "should be in mode size" do
    event=Event.new(@attr.merge(:mode => 8))
    event.should_not be_valid
  end

  it "should have start_at in future" do
    event=Event.new(@attr.merge(:start_at => 1.week.ago))
    event.should_not be_valid
  end

  it "should have mask equals 0 if mode equals 0" do
    event=Event.new(@attr.merge(:mask => 1))
    event.should_not be_valid
  end

  it "should have mask less than 2**7 if mode equals 1" do
    event=Event.new(@attr.merge(:mask => 2**7, :mode => 1))
    event.should_not be_valid
  end

  it "should have mask less than 2**31 if mode equals 2" do
    event=Event.new(@attr.merge(:mask => 2**31, :mode => 2))
    event.should_not be_valid
  end

end

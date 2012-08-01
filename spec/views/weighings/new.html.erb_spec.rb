# encoding: utf-8
require 'spec_helper'

describe "weighing/new.html.erb", :type => :spec do
  before(:each) do
    login(@stefan)
    @date = Date.new(year=2012, month=7, day=31)
    @date2 = Date.new(year=2012, month=7, day=30)
  end

  it "allows to enter weighing" do
    enter_weighing(2, @date)
    page.current_path.should == diagram_weighings_path
  end

  it "allows to enter second weighing with different date" do
    enter_weighing(2, @date)
    page.current_path.should == diagram_weighings_path
    enter_weighing(3, @date2)
    page.current_path.should == diagram_weighings_path
  end

  it "prohibits to enter further weighing with the same date" do
    enter_weighing(2, @date)
    page.current_path.should == diagram_weighings_path
    enter_weighing(3, @date)
    page.should have_selector("span.error", :text => "existiert bereits")
  end

  it "checks for the entry of a weight" do
    visit "/weighings/new"
    select_a_date(@date, :from => "weighing_date")
    click_button "Speichern"
    page.should have_selector("span.error", :text => "geben Sie ein Gewicht ein")
  end
end

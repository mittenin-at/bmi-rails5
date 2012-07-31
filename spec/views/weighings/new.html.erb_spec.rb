# encoding: utf-8
require 'spec_helper'

describe "weighing/new.html.erb", :type => :spec do
  before(:each) do
    login
  end

  it "allows to enter weighing" do
    visit "/weighings/new"
    fill_in "Gewicht", :with => "1"
    date = Date.new(year=2012, month=7, day=31)
    select_a_date(date, :from => "weighing_date" )
    click_button "Speichern"
    page.current_path.should == diagram_weighings_path
  end

  it "allows to enter second weighing with different date" do
    visit "/weighings/new"
    fill_in "Gewicht", :with => "2"
    date1 = Date.new(year=2011, month=1, day=1)
    select_a_date(date1, :from => "weighing_date" )
    click_button "Speichern"
    page.current_path.should == diagram_weighings_path
    visit "/weighings/new"
    fill_in "Gewicht", :with => "3"
    date2 = Date.new(year=2012, month=7, day=30)
    select_a_date(date2, :from => "weighing_date")
    click_button "Speichern"
    page.current_path.should == diagram_weighings_path
  end

  it "prohibits to enter further weighing with the same date" do
    visit "/weighings/new"
    fill_in "Gewicht", :with => "4"
    date =  Date.new(year=2012, month=7, day=31)
    select_a_date(date, :from => "weighing_date")
    click_button "Speichern"
    page.current_path.should == diagram_weighings_path
    visit "/weighings/new"
    fill_in "Gewicht", :with => "5"
    select_a_date(date, :from => "weighing_date")
    click_button "Speichern"
    page.should have_selector("span.error", :text => "existiert bereits")
  end
end

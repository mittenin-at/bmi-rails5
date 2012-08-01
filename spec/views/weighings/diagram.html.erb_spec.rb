# encoding: utf-8
require 'spec_helper'

describe "weighing/diagram.html.erb", :type => :spec do
  before(:each) do
    login(@stefan)
    @date = Date.new(year=2012, month=7, day=31)
  end

  it "displays no diagram without weighings" do
    visit diagram_weighings_path
    page.should have_selector("p", :text => "Noch keine Wägung")
    page.current_path.should == new_weighing_path
  end

  it "displays no diagram without weighings" do
    enter_weighing(2, @date)
    visit diagram_weighings_path
    page.should have_selector("h2", :text => "Diagramm")
    page.current_path.should == diagram_weighings_path
  end
end
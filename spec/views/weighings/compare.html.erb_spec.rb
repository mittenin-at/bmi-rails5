# encoding: utf-8
require 'spec_helper'

describe "weighing/compare.html.html.erb", :type => :spec do
  before(:each) do
    @date = Date.new(year=2012, month=7, day=31)
  end

  it "should be possible to compare two diagrams" do
    login(@stefan)
    enter_weighing(118, @date)
    visit "/logout"
    login(@michael)
    enter_weighing(100, @date)
    visit select_competitor_weighings_path
    page.should have_selector("option", text: @stefan.email)
    page.select @stefan.email, from: "competitor_id"
    click_button "Vergleichen"
    page.current_path.should == compare_weighings_path
  end

  it "should not be possible to compare to a private user's diagram" do
    login(@angsthase)
    enter_weighing(118, @date)
    visit "/logout"
    login(@michael)
    enter_weighing(100, @date)
    visit select_competitor_weighings_path
    page.should_not have_selector("option", text: @angsthase.email)
  end
end

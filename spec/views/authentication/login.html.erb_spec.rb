require 'spec_helper'

describe "authentication/login.html.erb", :type => :spec do
  it "displays an email field an a password field" do
    visit "/"
    fill_in "email", :with => "stefan.haslinger@mittenin.at"
    fill_in "password", :with => "mittenin.at"
  end
end

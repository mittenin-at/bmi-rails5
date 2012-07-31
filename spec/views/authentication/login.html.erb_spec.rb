# encoding: utf-8
require 'spec_helper'

describe "authentication/login.html.erb", :type => :spec do
  it "allows successfull login" do
    login
    page.should have_selector("h2.title", :text => "Neuer Eintrag Wägung")
  end

  it "prohibits login with false credentials" do
    visit "/"
    fill_in "email", :with => "stefan.haslinger@mittenin.at"
    fill_in "password", :with => "wrong_pass"
    click_button "Anmelden"
    page.should have_selector("p", :text => "Ungültige Benutzername / Passwort - Kombination")
  end
end

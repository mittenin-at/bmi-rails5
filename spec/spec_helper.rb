# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

#HAS: 20120726, Für Capybara
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|

  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234

  config.order = "random"

  config.before(:each) {
    @stefan = User.new(email: "stefan.haslinger@mittenin.at", height: "193",
                       invitation_id: "123", public: "true")
    @stefan.password = "mittenin.at"
    @stefan.save!
    @michael = User.new(email: "michael.stranka@mittenin.at", height: "175",
                       invitation_id: "0815", public: "true")
    @michael.password = "mittenin.at"
    @michael.save!
    @angsthase = User.new(email: "angsthase@mittenin.at", height: "175",
                          invitation_id: "0816")
    @angsthase.password = "mittenin.at"
    @angsthase.save!
  }

  def login(user)
    visit "/"
    fill_in "email", :with => user.email
    fill_in "password", :with => user.password
    click_button "Anmelden"
  end

  def enter_weighing(weight, date)
    visit "/weighings/new"
    fill_in "Gewicht", :with => weight
    select_a_date(date, :from => "weighing_date")
    click_button "Speichern"
  end

  def select_by_id(id, options = {})
    field = options[:from]
    option_xpath = "//*[@id='#{field}']/option[#{id}]"
    option_text = find(:xpath, option_xpath).text
    page.select option_text, :from => field
  end

  def select_a_date(date, options = {})
    raise ArgumentError, 'from is a required option' if options[:from].blank?
    field = options[:from].to_s
    page.select date.year.to_s,               :from => "#{field}_1i"
    page.select t(Date::MONTHNAMES)[date.month], :from => "#{field}_2i"
    page.select date.day.to_s,                :from => "#{field}_3i"
  end

  config.after do
    DatabaseCleaner.clean
  end
end

module ::RSpec::Core
  class ExampleGroup
    include Capybara::DSL
    include Capybara::RSpecMatchers
  end
end



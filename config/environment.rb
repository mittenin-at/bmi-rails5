# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Bmi::Application.initialize!

ActionMailer::Base.smtp_settings = {
   :domain => "floridsdorf.mittenin.at",
   :enable_starttls_auto => false
}


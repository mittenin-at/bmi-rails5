# Load the rails application
require_relative 'application'

# Initialize the rails application
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
   :domain => "floridsdorf.mittenin.at",
   :enable_starttls_auto => false
}
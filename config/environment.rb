# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Bmi::Application.initialize!

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if html_tag =~ /<label/
    %|<div class="fieldWithErrors">#{html_tag} <span class="error">#{[instance.error_message].join(', ')}</span></div>|.html_safe
  else
    html_tag
  end
end

ActionMailer::Base.smtp_settings = {
   :domain => "floridsdorf.mittenin.at",
   :enable_starttls_auto => false
}


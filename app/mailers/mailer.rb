class Mailer < ActionMailer::Base
  default :from => "einladung@bmi.mittenin.at"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.invitation.subject
  #

  def invitation(invitation, signup_url)
    @signup_url = signup_url
   	mail(:to => "#{invitation.recipient_email} <#{invitation.recipient_email}>", :subject => 'Einladung')
    invitation.update_attribute(:sent_at, Time.now)
  end
end


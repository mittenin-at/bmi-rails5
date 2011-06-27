class Mailer < ActionMailer::Base
  default :from => "einladung@bmi.mittenin.at"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.invitation.subject
  #
  
  def invitation(invitation, signup_url)
    subject    'Einladung'
    recipients invitation.recipient_email
    from       'einladung@bmi.mittenin.at'
    body       :invitation => invitation, :signup_url => signup_url
    invitation.update_attribute(:sent_at, Time.now)
  end
 
end

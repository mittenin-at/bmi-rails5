class Mailer < ActionMailer::Base
  default :from => "einladung@bmi.mittenin.at"

  def invitation(invitation, signup_url)
    @signup_url = signup_url
   	mail(:to => "#{invitation.recipient_email}", :subject => 'Einladung')
    invitation.update_attribute(:sent_at, Time.now)
  end
end


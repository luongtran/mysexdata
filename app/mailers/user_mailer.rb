class UserMailer < ActionMailer::Base
  default from: "MySexData Team<#{ADMIN_EMAIL}>"

  def invitation_email(user, email)
    @user = user
    attachments.inline['light-logo.png'] = File.read(Dir.pwd+'/app/views/user_mailer/light-logo.png')
    mail to: email, subject: "My Sex Data - Invitación"
  end

  def report_abuse(user, content)
    @user = user
    @content = content
    attachments.inline['light-logo.png'] = File.read(Dir.pwd+'/app/views/user_mailer/light-logo.png')
    mail to: ADMIN_EMAIL, subject: "My Sex Data - Abuso"
  end

end

class UserMailer < ActionMailer::Base
  default from: "MySexData Team<info@mysexdata.com>"

  def invitation_email(user, email)
    @user = user
    attachments.inline['light-logo.png'] = File.read(Dir.pwd+'/app/views/user_mailer/light-logo.png')
    mail to: email, subject: "My Sex Data Invitation"
  end

end

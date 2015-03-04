class UserNotifier < ApplicationMailer
  default :from => 'admin@donkeydocket.com'
  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
        :subject => 'Thank you for signing up to DonkeyDocket.com.')
  end
end

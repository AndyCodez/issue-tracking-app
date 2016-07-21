# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/account_activation
  def account_activation
    user = User.last
    user.activation_token = User.new_token
    UserMailer.account_activation(user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    user = User.last
    user.reset_token = User.new_token
    UserMailer.password_reset(user)
  end


  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/issue_raised
  def issue_raised
    user = User.last
    UserMailer.issue_raised(user)
  end

  def issue_opened
    user = User.last
    UserMaile.issue_opened(user)
  end

  def issue_assigned
    user = User.last
    UserMailer.issue_assigned(user)
  end

  def issue_resolved
    user = User.last
    UserMailer.issue_resolved(user)
  end

  def issue_closed
    user = User.last
    UserMailer.issue_closed(user)
  end

end

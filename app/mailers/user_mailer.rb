class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account Activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password Reset"
  end

  def issue_assigned(user)
    @user = user
    mail to: user.email, subject: "Issue Assigned"
  end

  def issue_resolved(user)
    @user = user
    mail to: user.email, subject: "Issue Resolved"
  end

  def issue_closed(user)
    @user = user
    mail to: user.email, subject: "Issue Closed"
  end

  def issue_raised(user)
    #The user that raised the issue
    @user = user
    mail to: 'admin@issuetrackerproject.com', subject: "Issue Raised"
  end

end

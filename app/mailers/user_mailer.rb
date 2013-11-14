class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def order_expiration_email(options = {})
    @user = options[:user]
    @order = options[:order]
    @positive = options[:positive]
    @any_counter_orders = options[:any_counter_orders]
    email_with_name = "#{@user.name} <#{@user.email}>"
    mail(to: email_with_name, subject: "EatLoco Order Notification")
  end

end

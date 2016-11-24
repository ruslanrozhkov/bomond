class OrderNotifier < ActionMailer::Base
  default from: 'Sam Ruby from@example.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.received.subject
  #
  def received(order)
    @order = order

    mail to: order.email, subject: 'Подтверждение заказа в Pragmatic Store'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #
  def shipped(order)
    @order = order

    mail to: order.email, subject: 'Заказ из Pragmatic Store отправлен'
  end

  def cart_error_mailer(cart_id)
    @cart_id = cart_id

    mail to:  'seoblad@mail.ru', subject: 'Invalid cart access'
  end
end

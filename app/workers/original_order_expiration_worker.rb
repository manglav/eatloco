class OriginalOrderExpirationWorker
  include Sidekiq::Worker

  def perform(original_order_id)
    #need to create notifications and emails for each type.
    # find out how to delete dependent tasks in case someone deletes an original order.
    # three options
    # 1. No one responded to order
    # 2. People responded, but no winner.
    # 3. People responded, one winner.
    original_order = OriginalOrder.find(original_order_id)
    winning_counter_order = original_order.winner # nil if not present
    lost_orders = original_order.lost_orders

    if winning_counter_order
      positive = true
    else
      positive = false
    end

    if lost_orders
      any_counter_orders = true
    else
      any_counter_orders = false
    end

    original_user_options = {
      user: original_order.user,
      order: original_order,
      positive: positive,
      any_counter_orders: any_counter_orders
    }

    UserMailer.order_expiration_email(original_user_options).deliver

    lost_orders.each do |lost_order|
      counter_user_options = {
        user: lost_order.user,
        order: lost_order,
        positive: positive,
        any_counter_orders: any_counter_orders
      }
      UserMailer.order_expiration_email(counter_user_options).deliver
    end


    if winning_counter_order # if there is a winner
      winner_options = {
        user: winning_counter_order.user,
        order: winning_counter_order,
        positive: positive,
        any_counter_orders: any_counter_orders
      }
      UserMailer.order_expiration_email(winner_options).deliver # winner
    end
  end

end
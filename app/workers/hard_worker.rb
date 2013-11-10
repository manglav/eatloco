class HardWorker
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
    if original_order.winner_id?
      #3
      message_original_user(original_order.user_id, true)
=begin
      Congratulations! We are writing to tell you that your order for :Dish_name has been fulfilled! As a reminder, here are the details you agreed to:
      :counter_order_winner_details

      As a reminder, you have 24 hours to pay the amount.  The maker has full permission not to fulfill the order if there is no payment.

      Happy Eating!
=end
      message_counter_user(original_order.winner.user_id, true)
=begin
      Congratulations! We are writing to tell you that your counter_order for :Dish_name and :original_order_user_name has been fulfilled! As a reminder, here are the details you agreed to:
      :counter_order_winner_details

      As a reminder, you should be payed within 24 hours.  You have full permission not to fulfill the order if there is no payment.

      Happy Making!
=end
      original_order.lost_orders.each do |lost_order|
        message_counter_user(lost_order.user_id, false)
=begin
      Apologies. We are writing to tell you that your counter_order for :Dish_name and :original_order_user_name has not been selected.

        Try setting a lower price, or higher weight in the future.

      Maybe next time!
=end

      end
    else
      if original_order.counter_order_ids.any?
        #2
        message_original_user(original_order.user_id, false)

=begin
      Apologies. We are writing to tell you that your order for :food_name will not be fulfilled because it has expired, and no winner was selected.

        Try ordering again in the future.

      Maybe next time!
=end

        original_order.lost_orders.each do |lost_order|
          message_counter_user(counter_order.user_id, false)

=begin
      Apologies. We are writing to tell you that your counter_order for :Dish_name and :original_order_user_name has not been selected. In fact, no winner was selected.

        Try setting a lower price, or higher weight in the future.

      Maybe next time!
=end

        end
      else
        #1
        message_original_user(original_order.user_id, false)

=begin
      Apologies. We are writing to tell you that your order for :food_name will not be fulfilled because it has expired, and no counter_orders were made.

        Try ordering again with a higher price or lower weight in the future.

      Maybe next time!
=end

      end
    end
  end

  def message_original_user(user_id, status)
    user = User.find(user_id)

    if status # is true
      #send positve email to user
      #send positive notifcation to user
    else # is false
      #send negative email to user
      #send negative notification to user
    end
  end

  def message_counter_user(user_id, status)
    if status # is true
      #send positve counter email to user
      #send positive counter notifcation to user
    else # is false
      #send negative counter email to user
      #send negative counter notification to user
    end
  end

end
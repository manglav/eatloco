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
    if original_order.winner_id?
      #3
      message_original_user(original_order.user_id, :true)
      message_counter_user(original_order.winner.user_id, :true)
      original_order.lost_orders.each do |lost_order|
        message_counter_user(lost_order.user_id, :false)
      end
    else
      if original_order.counter_order_ids.any
        #2
        message_original_user(original_order.user_id, :false)
        original_order.counter_orders.each do |counter_order|
          message_counter_user(counter_order.user_id, :false)
        end
      else
        #1
        message_original_user(original_order.user_id, :false)
      end
    end
  end

  def message_original_user(user_id, status)
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
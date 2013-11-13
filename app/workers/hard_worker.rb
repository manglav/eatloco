class HardWorker
  include Sidekiq::Worker
<<<<<<< Local Changes


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

    @user = options[:user]
    @order = options[:order]
    @positive = options[:positive]
    @any_counter_orders = options[:any_counter_orders]

    message_user(user) main user
    message_user(user) winner user

    for each lost order
      message_user(lost_user)
    end






end
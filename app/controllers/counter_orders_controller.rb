class CounterOrdersController < ApplicationController
  # GET /counter_orders
  # GET /counter_orders.json
  def index
    @counter_orders = CounterOrder.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @counter_orders }
    end
  end

  # GET /counter_orders/1
  # GET /counter_orders/1.json
  def show
    @counter_order = CounterOrder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @counter_order }
    end
  end

  # GET /counter_orders/new
  # GET /counter_orders/new.json
  def new
    @original_order = OriginalOrder.find(params[:original_order_id])

    relevant_fields = CounterOrder.accessible_attributes.as_json - ["user_id"]
    # Get's overlapping fields between original_order and counter_order
    attrs = @original_order.as_json.slice(*relevant_fields)
    # creates hash of original order data of relevant information
    @counter_order = @original_order.counter_orders.new(attrs)
    #initialize counter_order with original_order data

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @counter_order }
    end
  end

  # GET /counter_orders/1/edit
  def edit
    @counter_order = CounterOrder.find(params[:id])
  end

  # POST /counter_orders
  # POST /counter_orders.json
  def create
    @original_order = OriginalOrder.find(params[:original_order_id])
    @counter_order = @original_order.counter_orders.new(params[:counter_order])
    @counter_order.user_id = current_user.id

    respond_to do |format|
      if @counter_order.save
        format.html { redirect_to @counter_order, notice: 'Counter order was successfully created.' }
        format.json { render json: @counter_order, status: :created, location: @counter_order }
      else
        format.html { render action: "new" }
        format.json { render json: @counter_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /counter_orders/1
  # PUT /counter_orders/1.json
  def update
    @counter_order = CounterOrder.find(params[:id])

    respond_to do |format|
      if @counter_order.update_attributes(params[:counter_order])
        format.html { redirect_to @counter_order, notice: 'Counter order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @counter_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /counter_orders/1
  # DELETE /counter_orders/1.json
  def destroy
    @counter_order = CounterOrder.find(params[:id])
    @counter_order.destroy

    respond_to do |format|
      format.html { redirect_to counter_orders_url }
      format.json { head :no_content }
    end
  end
end

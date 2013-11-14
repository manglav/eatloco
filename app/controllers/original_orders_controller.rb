class OriginalOrdersController < ApplicationController
  # GET /original_orders
  # GET /original_orders.json
  def index
    @original_orders = OriginalOrder.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @original_orders }
    end
  end

  # GET /original_orders/1
  # GET /original_orders/1.json
  def show
    @original_order = OriginalOrder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @original_order }
    end
  end

  # GET /original_orders/new
  # GET /original_orders/new.json
  def new
    @available_dishes = Menu.joins(:dishes).uniq
    @original_order = OriginalOrder.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @original_order }
    end
  end

  # GET /original_orders/1/edit
  def edit
    @original_order = OriginalOrder.includes(:counter_orders).find(params[:id])
    @counter_orders = @original_order.counter_orders
  end

  # POST /original_orders
  # POST /original_orders.json
  def create
    @original_order = current_user.original_orders.new(params[:original_order].slice( *OriginalOrder.accessible_attributes ))
    @original_order.menu_id = params[:original_order][:menu_id]

    respond_to do |format|
      if @original_order.save
        OriginalOrderExpirationWorker.perform_at(@original_order.expiration_date, @original_order.id)
        format.html { redirect_to @original_order, notice: 'Original order was successfully created.' }
        format.json { render json: @original_order, status: :created, location: @original_order }
      else
        format.html { render action: "new" }
        format.json { render json: @original_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /original_orders/1
  # PUT /original_orders/1.json
  def update
    @original_order = OriginalOrder.find(params[:id])

    respond_to do |format|
      if @original_order.update_attributes(params[:original_order])
        format.html { redirect_to @original_order, notice: 'Original order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @original_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /original_orders/1
  # DELETE /original_orders/1.json
  def destroy
    @original_order = OriginalOrder.find(params[:id])
    @original_order.destroy

    respond_to do |format|
      format.html { redirect_to original_orders_url }
      format.json { head :no_content }
    end
  end
end

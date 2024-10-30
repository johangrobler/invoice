class MessagesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_message, only: %i[ show edit update destroy ]

  # GET /messages or /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1 or /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    invoice = Invoice.find(params[:id])
    @message = Message.new
    @message.user = current_user
    @message.invoice = invoice

    if invoice

     @message.email = invoice.customer.email
     @message.status = "new"

     @message.subject = "Here is your invoice: #" + invoice.id.to_s + Time.now.to_s
     @message.body = "Please find attached your invoice for: " + invoice.customer.name.to_s + ". Invoice total: $" + invoice.amount.to_s

    end
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params)
    @message.user = current_user
    respond_to do |format|
      if @message.save

        @message.send_invoice_email 

        format.html { redirect_to @message, notice: "Message was successfully created." }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy!

    respond_to do |format|
      format.html { redirect_to messages_path, status: :see_other, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.expect(message: [ :user_id, :subject, :body, :invoice_id, :status, :email ])
    end
end
